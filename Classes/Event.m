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

- (NSString *)description
{
  NSString *result;
  result = [[NSString alloc] initWithFormat:@"route = '%@' destination = '%@' schedTime = '%@' goalTime = '%@' goalDeviation = '%@' type = '%@' distanceToGoal = '%@'", route, destination, schedTime, goalTime, goalDeviation, type, distanceToGoal];
  [result autorelease];
  return result;
}

@end
