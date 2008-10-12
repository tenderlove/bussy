//
//  BussyAppDelegate.m
//  Bussy
//
//  Created by Aaron Patterson on 10/9/08.
//  Copyright __MyCompanyName__ 2008. All rights reserved.
//

#import "BussyAppDelegate.h"
#import "BussyViewController.h"
#import "ArrivalsViewController.h"

#include <sqlite3.h>

@implementation BussyAppDelegate

@synthesize window;
@synthesize busStopsController;
@synthesize bussyTabBarController;
@synthesize stops;

NSString *DATABASE_RESOURCE_NAME = @"bus";
NSString *DATABASE_RESOURCE_TYPE = @"db";
NSString *DATABASE_FILE_NAME = @"bus.db";

NSString *dbFilePath;

- (BOOL) initializeDb
{
	NSLog (@"initializeDB");

	// look to see if DB is in known location (~/Documents/$DATABASE_FILE_NAME)
  //START:code.DatabaseShoppingList.findDocumentsDirectory
	NSArray *searchPaths =
		NSSearchPathForDirectoriesInDomains
		(NSDocumentDirectory, NSUserDomainMask, YES);

	NSString *documentFolderPath = [searchPaths objectAtIndex: 0];
	dbFilePath = [documentFolderPath stringByAppendingPathComponent:
				  DATABASE_FILE_NAME];

	[dbFilePath retain];

	if (! [[NSFileManager defaultManager] fileExistsAtPath: dbFilePath]) {
		// didn't find db, need to copy
		NSString *backupDbPath = [[NSBundle mainBundle]
			pathForResource:DATABASE_RESOURCE_NAME
			ofType:DATABASE_RESOURCE_TYPE];
		if (backupDbPath == nil) {
			// couldn't find backup db to copy, bail
      NSLog(@"Couldn't find database");
			return NO;
		} else {
			BOOL copiedBackupDb = [[NSFileManager defaultManager]
				copyItemAtPath:backupDbPath
				toPath:dbFilePath
				error:nil];
			if (! copiedBackupDb) {
        NSLog(@"Couldn't copy database");
				return NO;
			}
		}
	}
  NSLog(@"Success!: %@", dbFilePath);
	return YES;
}

- (NSArray *)stops
{
  sqlite3 *db;

  if(nil != stops) {
    NSLog(@"cache hit");
    return stops;
  }

  int dbrc = sqlite3_open([dbFilePath UTF8String], &db);
  if(dbrc) {
    NSLog(@"Couldn't open database");
    return nil;
  }

  NSString * select = @"select name from stops";
  const char * s = [select UTF8String];
  int length = [select length];
  sqlite3_stmt *dbps;

  dbrc = sqlite3_prepare_v2(db, s, length, &dbps, NULL); 

  if(dbrc) {
    NSLog(@"Couldn't prepare statement: %d", dbrc);
    return nil;
  }

  stops = [[NSMutableArray alloc] init];
  while(SQLITE_ROW == sqlite3_step(dbps)) {
    const unsigned char* itemValueC = sqlite3_column_text (dbps, 0);
    NSString *itemValue = [[NSString alloc]
      initWithCString:itemValueC encoding: NSUTF8StringEncoding];
    [stops addObject:itemValue];
    [itemValue release];
  }
  sqlite3_finalize(dbps);
  sqlite3_close(db);

  return stops;
}

- (void)createDefaultData
{
  data = [[NSMutableDictionary dictionary] retain];

  [data setValue:[NSMutableArray arrayWithObjects:@"8", @"8", nil]
          forKey: @"Broadway and Denny"];
  [data setValue:[NSMutableArray arrayWithObjects:@"26", @"26", nil]
          forKey: @"Denny and Dexter"];
  [data setValue:[NSMutableArray arrayWithObjects:@"32", @"23", nil]
          forKey: @"Fremont and 34th"];
}

- (NSArray *)arrivalsForStop:(NSString *)stopName
{
  return [data valueForKey:stopName];
}

- (void)stopClicked:(NSString *)stopName
{
	arrivalsController.arrivals = [self arrivalsForStop:stopName];
	//[navController pushViewController:arrivalsController animated:YES];
}

- (void)applicationDidFinishLaunching:(UIApplication *)application {	
	//navController.viewControllers = [NSArray arrayWithObject:busStopsController];
	// Override point for customization after app launch	
  [window addSubview:bussyTabBarController.view];
	[window makeKeyAndVisible];
  [self initializeDb];
  [self createDefaultData];
}


- (void)dealloc {
    [busStopsController release];
	[window release];
	[super dealloc];
}


@end
