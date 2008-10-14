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

- (void)dealloc
{
  [type release];
  [destination release];
  [super dealloc];
}

@end
