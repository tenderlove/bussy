//
//  Event.m
//  Bussy
//
//  Created by Aaron Patterson on 10/13/08.
//  Copyright 2008 __MyCompanyName__. All rights reserved.
//

#import "Event.h"
#import "EventBuilder.h"

@implementation Event

@synthesize goalDeviation;
@synthesize schedTime;
@synthesize goalTime;
@synthesize type;
@synthesize distanceToGoal;
@synthesize destination;
@synthesize route;

+ (void) fetchEventsWithLocationId:(NSInteger)locationId
                          delegate:(id)delegate
{
  NSString * urlString = [[NSString alloc]
    initWithFormat:@"http://ws.its.washington.edu:9090/transit/mybus/services/MybusService?method=getEventData&in0=30&in1=-10&in2=%d&in3=http%%3A%%2F%%2Ftransit.metrokc.gov", locationId];

  NSURL *url = [NSURL URLWithString: urlString];

  NSXMLParser * parser = [[NSXMLParser alloc] initWithContentsOfURL:url];
  EventBuilder * builder = [[EventBuilder alloc] initWithDelegate:delegate];
  [parser setDelegate:builder];
  [parser parse];
  [parser release];
}

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

- (NSComparisonResult)goalTimeCompare:(Event *)other
{
  if([goalTime intValue] < [[other goalTime] intValue])
    return NSOrderedAscending;

  if([goalTime intValue] > [[other goalTime] intValue])
    return NSOrderedDescending;

  return NSOrderedSame;
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
  if([route intValue] < [[other route] intValue])
    return NSOrderedAscending;

  if([route intValue] > [[other route] intValue])
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
