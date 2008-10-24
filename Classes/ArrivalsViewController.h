//
//  BusStopViewController.h
//  Bussy
//
//  Created by Aaron Patterson on 10/9/08.
//  Copyright 2008 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@class Stop;
@class FavoritesViewController;

@interface ArrivalsViewController : UIViewController <UITableViewDataSource> {
	IBOutlet UITableView *tableView;
  IBOutlet UITableViewCell *loadingCell;
  IBOutlet UITableViewCell *noArrivalsCell;
  IBOutlet UITableViewCell *favoritesCell;

  IBOutlet FavoritesViewController *favoritesController;
	IBOutlet UINavigationController *navController;

	NSArray *arrivals;
  BOOL loadingBusData;
  NSMutableString *responseData;
  NSNumber * stopKey;
  Stop * stop;
  UIAlertView *baseAlert;
}

- (IBAction)addToFavorites:(id)sender;

@property (nonatomic, retain) NSArray *arrivals;
@property (nonatomic, retain) Stop *stop;
@property BOOL loadingBusData;
@property (nonatomic, retain) NSNumber * stopKey;

- (UITableViewCell *)loadingCell;
- (void)refresh:(id)sender;

@end
