//
//  AddFavoriteViewController.m
//  Bussy
//
//  Created by Aaron Patterson on 10/24/08.
//  Copyright 2008 __MyCompanyName__. All rights reserved.
//

#import "AddFavoriteViewController.h"
#import "FavoritesViewController.h"
#import "Stop.h"


@implementation AddFavoriteViewController

@synthesize stops;

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  UITableViewCell * cell =
    [tableView dequeueReusableCellWithIdentifier:@"stops"];

  if(nil == cell)
    cell = [[[UITableViewCell alloc] initWithFrame:CGRectZero reuseIdentifier:@"stops"] autorelease];

  cell.text = [[[appDelegate stops] objectAtIndex:indexPath.row] name];
  return cell;
}

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section
{
  return [[appDelegate stops] count];
}

- (IBAction)cancel:(id)sender
{
  [self dismissModalViewControllerAnimated:YES];
}

-       (void)tableView:(UITableView *)tableView
didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
  Stop * clickedStop = [[appDelegate stops] objectAtIndex:indexPath.row];

  [favoritesController createFavoriteStop:[clickedStop key]];
  [self dismissModalViewControllerAnimated:YES];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
  // Return YES for supported orientations
  return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
}


- (void)dealloc {
  [super dealloc];
}


@end
