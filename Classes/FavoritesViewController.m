//
//  FavoritesViewController.m
//  Bussy
//
//  Created by Aaron Patterson on 10/18/08.
//  Copyright 2008 __MyCompanyName__. All rights reserved.
//

#import "FavoritesViewController.h"
#import "BussyAppDelegate.h"
#import "Stop.h"
#import "ArrivalsViewController.h"
#import "Event.h"


@implementation FavoritesViewController

@synthesize stops;

- (void)createFavoriteStop:(NSNumber *)key
{
  [Stop createFavoriteStop:key];
  [self setStops:[Stop findAllFavorites]];
  [tableView reloadData];
}

- (NSInteger)tableView:(UITableView *)tv
 numberOfRowsInSection:(NSInteger)section {
  return [stops count];
}

- (UITableViewCell *)tableView:(UITableView *)tv
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  UITableViewCell * cell =
    [tv dequeueReusableCellWithIdentifier:@"favStops"];

  if(nil == cell)
    cell = [[[UITableViewCell alloc] initWithFrame:CGRectZero reuseIdentifier:@"favStops"] autorelease];

  cell.text = [[stops objectAtIndex:indexPath.row] name];
  cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
  return cell;
}

-       (void)tableView:(UITableView *)tableView
didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
  Stop * clickedStop = [[appDelegate stops] objectAtIndex:indexPath.row];

  [arrivalsController setStop:clickedStop];
  [arrivalsController setTitle:[clickedStop name]];
  [arrivalsController setStopKey:[clickedStop key]];
  [arrivalsController setLoadingBusData:YES];

  [Event fetchEventsWithLocationId:[clickedStop locationId]
                          delegate:arrivalsController];

  arrivalsController.navigationItem.rightBarButtonItem = nil;
  [navController pushViewController:arrivalsController animated:YES];
}

- (void)dealloc {
  [super dealloc];
}

- (void)viewWillAppear:(BOOL)animated {
  [self setStops:[Stop findAllFavorites]];
  [super viewWillAppear:animated];
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
}

@end

