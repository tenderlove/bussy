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

- (NSArray *)arrivalsForStop:(NSString *)stopName
{
	NSArray * arrivals = nil;
	if([@"Broadway and Denny" isEqualToString:stopName]) {
		arrivals = [NSArray arrayWithObjects:@"8", @"8", nil];
	}
	if([@"Denny and Dexter" isEqualToString:stopName]) {
		arrivals = [NSArray arrayWithObjects:@"26", @"26", nil];
	}
	if([@"Fremont and 34th" isEqualToString:stopName]) {
		arrivals = [NSArray arrayWithObjects:@"32", @"23", nil];
	}
	return arrivals;
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
}


- (void)dealloc {
    [busStopsController release];
	[window release];
	[super dealloc];
}


@end
