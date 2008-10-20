//
//  Stop.h
//  Bussy
//
//  Created by Aaron Patterson on 10/12/08.
//  Copyright 2008 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface Stop : NSObject {
  NSNumber * key;
  NSString * name;
  NSString * section;
  NSInteger locationId;
}

- (Stop *)initWithKey: (NSNumber *)key
                 name: (NSString *)name
              section: (NSString *)section
           locationId: (NSInteger)locationId;

+ (void)destroyFavoriteFor:(Stop *)stop;
+ (Stop *)findFavoriteByKey:(NSNumber *)key;
+ (void)createFavoriteStop:(NSNumber *)key;
+ (NSMutableArray *)findAllWhere:(NSString *)conditions;
+ (NSMutableArray *)findAll;
+ (NSMutableArray *)findAllFavorites;
+ (BOOL)initializeDb;

@property (readonly, retain) NSNumber * key;
@property (nonatomic, retain) NSString *name;
@property (nonatomic, retain) NSString *section;
@property (readonly) NSInteger locationId;

@end
