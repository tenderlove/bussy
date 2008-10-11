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

@implementation BussyAppDelegate

@synthesize window;
@synthesize busStopsController;
@synthesize stops;

- (NSArray *)stops
{
  return [data allKeys];
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
	[navController pushViewController:arrivalsController animated:YES];
}

- (void)applicationDidFinishLaunching:(UIApplication *)application {	
	navController.viewControllers = [NSArray arrayWithObject:busStopsController];
	// Override point for customization after app launch	
    [window addSubview:navController.view];
	[window makeKeyAndVisible];
  [self createDefaultData];
}


- (void)dealloc {
    [busStopsController release];
	[window release];
	[super dealloc];
}


@end
