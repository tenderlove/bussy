//
//  Stop.m
//  Bussy
//
//  Created by Aaron Patterson on 10/12/08.
//  Copyright 2008 __MyCompanyName__. All rights reserved.
//

#import "Stop.h"

#include <sqlite3.h>


@implementation Stop

@synthesize key;
@synthesize name;
@synthesize section;
@synthesize locationId;

NSString *DATABASE_RESOURCE_NAME = @"bus";
NSString *DATABASE_RESOURCE_TYPE = @"db";
NSString *DATABASE_FILE_NAME = @"bus.db";

NSString *dbFilePath;

+ (BOOL) initializeDb
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

- (Stop *)initWithKey: (NSNumber *)initKey
                 name: (NSString *)initName
              section: (NSString *)initSection
           locationId: (NSInteger)initLocationId
{
  [super init];
  [initKey retain];
  key = initKey;

  [self setName:initName];
  [self setSection:initSection];
  locationId = initLocationId;
  return self;
}

+ (NSMutableArray *)findAll
{
  [Stop initializeDb];
  sqlite3 *db;

  int dbrc = sqlite3_open([dbFilePath UTF8String], &db);
  if(dbrc) {
    NSLog(@"Couldn't open database");
    return nil;
  }

  NSString * select = @"select id, name, section, remote_id from stops";
  const char * s = [select UTF8String];
  int length = [select length];
  sqlite3_stmt *dbps;

  dbrc = sqlite3_prepare_v2(db, s, length, &dbps, NULL); 

  if(dbrc) {
    NSLog(@"Couldn't prepare statement: %d", dbrc);
    return nil;
  }

  NSMutableArray * stops = [[NSMutableArray alloc] init];
  while(SQLITE_ROW == sqlite3_step(dbps)) {
    // ID Column
    int primaryKeyValueI = sqlite3_column_int(dbps, 0);
    NSNumber *primaryKeyValue = [[NSNumber alloc]
      initWithInt: primaryKeyValueI];
    
    // Name column
    const char* itemValueC = (const char *) sqlite3_column_text (dbps, 1);
    NSString *name = [[NSString alloc]
      initWithCString:itemValueC encoding: NSUTF8StringEncoding];

    // Section column
    itemValueC = (const char *) sqlite3_column_text (dbps, 2);
    NSString *section = [[NSString alloc]
      initWithCString:itemValueC encoding: NSUTF8StringEncoding];

    // Location_ID column
    NSInteger locationId = sqlite3_column_int(dbps, 3);

    Stop * stop = [[Stop alloc] initWithKey: primaryKeyValue
                                       name: name
                                    section: section
                                 locationId: locationId];
    [stops addObject:stop];
    [stop release];
    [name release];
    [section release];
    [primaryKeyValue release];
  }
  sqlite3_finalize(dbps);
  sqlite3_close(db);

  return stops;
}

- (void)dealloc
{
  [key release];
  [name release];
  [section release];
  [super dealloc];
}

@end
