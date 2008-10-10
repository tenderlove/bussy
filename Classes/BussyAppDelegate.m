//
//  BussyAppDelegate.m
//  Bussy
//
//  Created by Aaron Patterson on 10/9/08.
//  Copyright __MyCompanyName__ 2008. All rights reserved.
//

#import "BussyAppDelegate.h"
#import "BussyViewController.h"

@implementation BussyAppDelegate

@synthesize window;
@synthesize busStopsController;

- (void)stopClicked:(NSString *)stopName
{
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
