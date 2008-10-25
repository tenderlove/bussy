//
//  AddFavoriteViewController.h
//  Bussy
//
//  Created by Aaron Patterson on 10/24/08.
//  Copyright 2008 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@class BussyAppDelegate;
@class FavoritesViewController;

@interface AddFavoriteViewController : UIViewController <UITableViewDataSource, UITableViewDelegate> {
  IBOutlet BussyAppDelegate *appDelegate;
  IBOutlet FavoritesViewController *favoritesController;

  NSArray *stops;

}

- (IBAction)cancel:(id)sender;

@property (nonatomic, retain) NSArray *stops;

@end
