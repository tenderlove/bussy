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
  Stop * clickedStop = [stops objectAtIndex:indexPath.row];

  [arrivalsController setStop:clickedStop];
  [arrivalsController setTitle:[clickedStop name]];
  [arrivalsController setStopKey:[clickedStop key]];
  [arrivalsController refresh:self];

  [navController pushViewController:arrivalsController animated:YES];
}

-   (void)tableView:(UITableView *)tv
 commitEditingStyle:(UITableViewCellEditingStyle)editingStyle
  forRowAtIndexPath:(NSIndexPath *)indexPath
{
  if(editingStyle == UITableViewCellEditingStyleDelete)
  {
    Stop * clickedStop = [stops objectAtIndex:indexPath.row];
    [Stop destroyFavoriteFor:clickedStop];
    [self setStops:[Stop findAllFavorites]];
    [tv deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath]
              withRowAnimation:UITableViewRowAnimationLeft];
  }
}

- (void)setEditing:(BOOL)editing
          animated:(BOOL)animated
{
  [super setEditing:editing animated:animated];
  [tableView setEditing:editing animated:animated];
}

- (void)dealloc {
  [super dealloc];
}

- (void)viewDidLoad
{
  self.navigationItem.leftBarButtonItem = self.editButtonItem;
}

- (void)viewWillAppear:(BOOL)animated {
  [self setStops:[Stop findAllFavorites]];
  [super viewWillAppear:animated];
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
}

@end

