//
//  BusStopViewController.h
//  Bussy
//
//  Created by Aaron Patterson on 10/9/08.
//  Copyright 2008 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@class Stop;

@interface ArrivalsViewController : UIViewController <UITableViewDataSource> {
	NSArray *arrivals;
	IBOutlet UITableView *tableView;
  Stop * stop;
  NSMutableString *responseData;
}

@property (nonatomic, retain) NSArray *arrivals;
@property (nonatomic, retain) Stop *stop;

@end
