//
//  BussyViewController.h
//  Bussy
//
//  Created by Aaron Patterson on 10/9/08.
//  Copyright __MyCompanyName__ 2008. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BussyAppDelegate;
@class ArrivalsViewController;

@interface BussyViewController : UITableViewController <UITableViewDataSource, UITableViewDelegate> {
  IBOutlet BussyAppDelegate *appDelegate;
  IBOutlet ArrivalsViewController *arrivalsController;
  IBOutlet UINavigationController *navController;
}

@end

