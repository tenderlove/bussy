//
//  BussyAppDelegate.h
//  Bussy
//
//  Created by Aaron Patterson on 10/9/08.
//  Copyright __MyCompanyName__ 2008. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BussyViewController;

@interface BussyAppDelegate : NSObject <UIApplicationDelegate> {
	IBOutlet UIWindow *window;
	IBOutlet BussyViewController *viewController;
}

@property (nonatomic, retain) UIWindow *window;
@property (nonatomic, retain) BussyViewController *viewController;

@end

