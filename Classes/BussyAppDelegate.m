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
#import "Stop.h"

@implementation BussyAppDelegate

@synthesize window;
@synthesize busStopsController;
@synthesize bussyTabBarController;
@synthesize stops;


- (NSArray *)stops
{
  if(nil == stops) {
    stops = [Stop findAll];
    [stops retain];
  }

  return stops;
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
}


- (void)dealloc {
  [busStopsController release];
  [stops release];
	[window release];
	[super dealloc];
}


@end
