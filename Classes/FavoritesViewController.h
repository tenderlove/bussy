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

@interface FavoritesViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>{
  IBOutlet BussyAppDelegate *appDelegate;
  IBOutlet UINavigationController *navController;
  IBOutlet ArrivalsViewController * arrivalsController;
	IBOutlet UITableView *tableView;
  NSArray *stops;
}

@property (nonatomic, retain) NSArray *stops;

- (void)createFavoriteStop:(NSNumber *)key;

@end
