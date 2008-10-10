//
//  BusStopViewController.h
//  Bussy
//
//  Created by Aaron Patterson on 10/9/08.
//  Copyright 2008 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface ArrivalsViewController : UIViewController <UITableViewDataSource> {
	NSArray *arrivals;
}

@property (nonatomic, retain) NSArray *arrivals;

@end
