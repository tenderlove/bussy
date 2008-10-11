//
//  BussyTabBarViewController.h
//  Bussy
//
//  Created by Aaron Patterson on 10/11/08.
//  Copyright 2008 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@class BussyAppDelegate;
@class BussyViewController;
@class ArrivalsViewController;

@interface BussyTabBarViewController : UITabBarController {
  IBOutlet BussyAppDelegate *appDelegate;
	IBOutlet BussyViewController *busStopsController;
	IBOutlet ArrivalsViewController *arrivalsController;
}

@property (nonatomic, retain) BussyViewController *busStopsController;

@end
