//
//  Event.m
//  Bussy
//
//  Created by Aaron Patterson on 10/13/08.
//  Copyright 2008 __MyCompanyName__. All rights reserved.
//

#import "Event.h"


@implementation Event

@synthesize goalDeviation;
@synthesize schedTime;
@synthesize goalTime;
@synthesize type;
@synthesize distanceToGoal;
@synthesize destination;
@synthesize route;

- (NSString *)title
{
  NSString *title = [NSString stringWithFormat:@"%@ - %@",
           route, [self direction]];
  return title;
}

- (NSString *)direction
{
  NSArray * components = [destination componentsSeparatedByString:@" - "];
  NSString * direction = [components objectAtIndex:0];
  return direction;
}

- (NSString *)destination
{
  NSArray * components = [destination componentsSeparatedByString:@" - "];
  if([components count] > 1)
    return [components objectAtIndex:1];

  return [components objectAtIndex:0];
}

- (NSString *)description
{
  NSString *result;
  result = [[NSString alloc] initWithFormat:@"route = '%@' destination = '%@' schedTime = '%@' goalTime = '%@' goalDeviation = '%@' type = '%@' distanceToGoal = '%@'", route, destination, schedTime, goalTime, goalDeviation, type, distanceToGoal];
  [result autorelease];
  return result;
}

- (NSComparisonResult)schedTimeCompare:(Event *)other
{
  if([schedTime intValue] < [[other schedTime] intValue])
    return NSOrderedAscending;

  if([schedTime intValue] > [[other schedTime] intValue])
    return NSOrderedDescending;

  return NSOrderedSame;
}

- (NSComparisonResult)routeCompare:(Event *)other
{
  if([schedTime route] < [[other route] intValue])
    return NSOrderedAscending;

  if([schedTime route] > [[other route] intValue])
    return NSOrderedDescending;

  return NSOrderedSame;
}

- (void)dealloc
{
  [goalDeviation release];
  [schedTime release];
  [goalTime release];
  [type release];
  [distanceToGoal release];
  [destination release];
  [route release];
  [super dealloc];
}

@end
