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

@interface BussyAppDelegate : NSObject <UIApplicationDelegate, UITabBarControllerDelegate> {
	NSMutableDictionary * data;
  NSMutableArray *stops;
	IBOutlet UIWindow *window;
	IBOutlet UITabBarController *bussyTabBarController;
	IBOutlet BussyViewController *busStopsController;
	IBOutlet ArrivalsViewController *arrivalsController;
}

@property (nonatomic, retain) UIWindow *window;
@property (nonatomic, retain) BussyViewController *busStopsController;
@property (nonatomic, retain) UITabBarController *bussyTabBarController;
@property (readonly) NSArray * stops;

- (void)stopClicked:(NSString *)stopName;

@end

