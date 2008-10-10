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


- (void)applicationDidFinishLaunching:(UIApplication *)application {	
	
	// Override point for customization after app launch	
    [window addSubview:busStopsController.view];
	[window makeKeyAndVisible];
}


- (void)dealloc {
    [busStopsController release];
	[window release];
	[super dealloc];
}


@end
