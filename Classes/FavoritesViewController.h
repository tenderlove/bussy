//
//  FavoritesViewController.h
//  Bussy
//
//  Created by Aaron Patterson on 10/18/08.
//  Copyright 2008 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@class BussyAppDelegate;
@class ArrivalsViewController;
@class AddFavoriteViewController;

@interface FavoritesViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>{
  IBOutlet BussyAppDelegate *appDelegate;
  IBOutlet UINavigationController *navController;
  IBOutlet ArrivalsViewController * arrivalsController;
  IBOutlet AddFavoriteViewController * addFavoriteController;
	IBOutlet UITableView *tableView;
  NSArray *stops;
}

@property (nonatomic, retain) NSArray *stops;

- (void)createFavoriteStop:(NSNumber *)key;
- (IBAction)new:(id)sender;

@end
