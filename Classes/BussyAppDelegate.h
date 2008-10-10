//
//  BussyAppDelegate.h
//  Bussy
//
//  Created by Aaron Patterson on 10/9/08.
//  Copyright __MyCompanyName__ 2008. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BussyViewController;
@class ArrivalsViewController;

@interface BussyAppDelegate : NSObject <UIApplicationDelegate> {
	IBOutlet UIWindow *window;
	IBOutlet BussyViewController *busStopsController;
	IBOutlet UINavigationController *navController;
	IBOutlet ArrivalsViewController *arrivalsController;
}

@property (nonatomic, retain) UIWindow *window;
@property (nonatomic, retain) BussyViewController *busStopsController;

- (void)stopClicked:(NSString *)stopName;

@end

