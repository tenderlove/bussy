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

  NSString *backupDbPath = [[NSBundle mainBundle]
    pathForResource:DATABASE_RESOURCE_NAME
    ofType:DATABASE_RESOURCE_TYPE];

  if(nil == backupDbPath) {
    NSLog(@"Couldn't find database");
    return NO;
  }

  [dbFilePath retain];

  BOOL fileExists =
    [[NSFileManager defaultManager] fileExistsAtPath: dbFilePath];

  BOOL sourceIsNewer = NO;

  if(fileExists) {
    NSDictionary * destStat = 
      [[NSFileManager defaultManager]
        attributesOfItemAtPath:dbFilePath error:NULL];
    NSDictionary * srcStat = 
      [[NSFileManager defaultManager]
        attributesOfItemAtPath:backupDbPath error:NULL];

    NSDate * srcMTime = [srcStat objectForKey:NSFileModificationDate];
    NSDate * destMTime = [destStat objectForKey:NSFileModificationDate];
    if(NSOrderedDescending == [srcMTime compare:destMTime])
      sourceIsNewer = YES;
  }

  if(sourceIsNewer)
    [[NSFileManager defaultManager] removeItemAtPath:dbFilePath error:NULL];

  if (!fileExists || sourceIsNewer) {
    NSError * error;
    // didn't find db, need to copy
    BOOL copiedBackupDb = [[NSFileManager defaultManager]
      copyItemAtPath:backupDbPath
              toPath:dbFilePath
               error:&error];
    if (! copiedBackupDb) {
      NSLog(@"Couldn't copy database: %@", error);
      return NO;
    }
    NSLog(@"Copied database");
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

+ (void)createFavoriteStop:(NSNumber *)key
{
  sqlite3 *db;

  int dbrc = sqlite3_open([dbFilePath UTF8String], &db);
  if(dbrc) {
    NSLog(@"Couldn't open database");
    return;
  }

  NSString * select = [[NSString alloc]
    initWithFormat:@"insert into favorite_stops (stop_id) values (%@)",
    key
  ];
  const char * s = [select UTF8String];
  int length = [select length];
  sqlite3_stmt *dbps;

  dbrc = sqlite3_prepare_v2(db, s, length, &dbps, NULL); 

  if(dbrc) {
    NSLog(@"Couldn't prepare statement: %d", dbrc);
    return;
  }

  while(SQLITE_ROW == sqlite3_step(dbps)) { }
  sqlite3_finalize(dbps);
  sqlite3_close(db);
}

+ (Stop *)findFavoriteByKey:(NSNumber *)key
{
  NSString * where = [[NSString alloc]
    initWithFormat:@"id in (select stop_id from favorite_stops where stop_id = %@)", key];

  NSMutableArray * stops = [Stop findAllWhere:where];

  if([stops count] > 0)
    return [stops objectAtIndex:0];

  return nil;
}

+ (NSMutableArray *)findAllFavorites
{
  return [Stop findAllWhere:@"id in (select stop_id from favorite_stops)"];
}

+ (NSMutableArray *)findAll
{
  return [Stop findAllWhere:@"1 = 1"];
}

+ (void)destroyFavoriteFor:(Stop *)stop
{
  sqlite3 *db;

  int dbrc = sqlite3_open([dbFilePath UTF8String], &db);
  if(dbrc) {
    NSLog(@"Couldn't open database");
    return;
  }

  NSString * select = [[NSString alloc]
    initWithFormat:@"delete from favorite_stops where stop_id = %@",
    [stop key]
  ];
  const char * s = [select UTF8String];
  int length = [select length];
  sqlite3_stmt *dbps;

  dbrc = sqlite3_prepare_v2(db, s, length, &dbps, NULL); 

  if(dbrc) {
    NSLog(@"Couldn't prepare statement: %d", dbrc);
    return;
  }

  while(SQLITE_ROW == sqlite3_step(dbps)) { }
  sqlite3_finalize(dbps);
  sqlite3_close(db);
}

+ (NSMutableArray *)findAllWhere:(NSString *)conditions
{
  sqlite3 *db;

  int dbrc = sqlite3_open([dbFilePath UTF8String], &db);
  if(dbrc) {
    NSLog(@"Couldn't open database");
    return nil;
  }

  NSString * select = [[NSString alloc]
    initWithFormat:@"select id, name, section, remote_id from stops where %@",
    conditions
  ];
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
