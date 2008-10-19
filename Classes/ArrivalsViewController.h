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
	NSArray *arrivals;
	IBOutlet UITableView *tableView;
  Stop * stop;
  NSMutableString *responseData;
  IBOutlet UITableViewCell *loadingCell;
  IBOutlet UITableViewCell *noArrivalsCell;
  IBOutlet FavoritesViewController *favoritesController;
  BOOL loadingBusData;
  NSNumber * stopKey;
}

@property (nonatomic, retain) NSArray *arrivals;
@property (nonatomic, retain) Stop *stop;
@property BOOL loadingBusData;
@property (nonatomic, retain) NSNumber * stopKey;

- (UITableViewCell *)loadingCell;

@end
