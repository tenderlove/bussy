//
//  BussyAppDelegate.h
//  Bussy
//
//  Created by Aaron Patterson on 10/9/08.
//  Copyright __MyCompanyName__ 2008. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BussyViewController;
@class BusStopViewController;

@interface BussyAppDelegate : NSObject <UIApplicationDelegate> {
	IBOutlet UIWindow *window;
	IBOutlet BussyViewController *busStopsController;
	IBOutlet UINavigationController *navController;
	IBOutlet BusStopViewController *busStopController;
}

@property (nonatomic, retain) UIWindow *window;
@property (nonatomic, retain) BussyViewController *busStopsController;

@end

