//
//  ArrivalsViewController.m
//  Bussy
//
//  Created by Aaron Patterson on 10/9/08.
//  Copyright 2008 __MyCompanyName__. All rights reserved.
//

#import "ArrivalsViewController.h"
#import "Stop.h"
#import "EventBuilder.h"
#import "Event.h"
#import "FavoritesViewController.h"


@implementation ArrivalsViewController

@synthesize arrivals;
@synthesize stop;
@synthesize loadingBusData;
@synthesize stopKey;

- (void)setLoadingBusData:(BOOL)a
{
  loadingBusData = a;
  [tableView reloadData];
}

- (void)setArrivals:(NSArray *)a
{
  [arrivals release];
  arrivals = [a retain];
  [tableView reloadData];
}

- (UITableViewCell *)loadingCell
{
  UITableViewCell * cell =
    [tableView dequeueReusableCellWithIdentifier:@"loadingCell"];
  if(nil == cell) cell = loadingCell;
  return cell;
}

- (UITableViewCell *)noArrivalsCell
{
  UITableViewCell * cell =
    [tableView dequeueReusableCellWithIdentifier:@"noArrivalsCell"];
  if(nil == cell) cell = noArrivalsCell;
  return cell;
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
  [self setLoadingBusData:NO];
  NSArray * array = [EventBuilder fromXML:responseData];
  NSArray * sorted = [array sortedArrayUsingSelector:@selector(goalTimeCompare:)];
  [array release];
  [self setArrivals:sorted];
}

- (void)connection:(NSURLConnection *)connection
  didFailWithError:(NSError *)error
{
  [baseAlert show];
}

- (void)connection:(NSURLConnection *)connection
didReceiveResponse:(NSURLResponse *)response
{
  NSLog (@"got a response");
  if(nil != responseData) [responseData release];

  responseData = [[NSMutableString alloc] init];
}

- (void)connection:(NSURLConnection *)connection
    didReceiveData:(NSData *)data
{
  NSString *newText = [[NSString alloc]
    initWithData:data
        encoding:NSUTF8StringEncoding];
  if (newText != NULL) {
    [responseData appendString:newText];
    [newText release];
  }
}

- (UITableViewCell *)tableView:(UITableView *)tv
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  if(YES == loadingBusData)
    return [self loadingCell];

  if([[self arrivals] count] == 0)
    return [self noArrivalsCell];

  UITableViewCell * cell = [tv dequeueReusableCellWithIdentifier:@"arrival"];
  if(nil == cell)
    cell = [[[UITableViewCell alloc] initWithFrame:CGRectZero reuseIdentifier:@"arrival"] autorelease];
  
  Event * event = [[self arrivals] objectAtIndex:indexPath.section];
  [cell setTextColor:[UIColor blackColor]];
  switch(indexPath.row)
  {
    int goalDeviation, schedTime, minute, hour, distanceToGoal;
    NSMutableString * timeString;
    case 0:
      cell.text = [event destination];
      return cell;
    case 1:
      distanceToGoal = [[event distanceToGoal] intValue];
      if(distanceToGoal < 0) {
        schedTime = [[event goalTime] intValue];
      } else {
        schedTime = [[event schedTime] intValue];
      }

      minute = (schedTime / 60) % 60;
      hour = (schedTime / 60) / 60;

      if(distanceToGoal < 0) {
        timeString = [NSMutableString
          stringWithFormat:@"Departed at %d:%02d ",
            hour > 12 ? hour - 12 : hour, minute
        ];
      } else {
        timeString = [NSMutableString
          stringWithFormat:@"Scheduled for %d:%02d ",
            hour > 12 ? hour - 12 : hour, minute
        ];
      }
      if(hour > 12 && hour < 24) {
        [timeString appendString:@"pm"];
      } else {
        [timeString appendString:@"am"];
      }
      cell.text = timeString;
      return cell;
    case 2:
      goalDeviation = [[event goalDeviation] intValue] / 60;
      if(goalDeviation == 0) {
        cell.text = @"On Time";
      } else if(goalDeviation < 0) {
        cell.text = @"Early";
        cell.text = [NSString
          stringWithFormat:@"%d minutes early", abs(goalDeviation)];
        [cell setTextColor:[UIColor redColor]];
      } else {
        cell.text = [NSString
          stringWithFormat:@"%d minute delay", goalDeviation];
        [cell setTextColor:[UIColor blueColor]];
      }
      return cell;
  }
  
  return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
  if(YES == loadingBusData)
    return 1;

  /* We didn't get any busses, so we'll display the sad bus stop message. */
  if([[self arrivals] count] == 0)
    return 1;

  return [[self arrivals] count];
}

- (NSString *)tableView:(UITableView *)tableView
titleForHeaderInSection:(NSInteger)section
{
  if(YES == loadingBusData)
    return @"I love you!";

  if([[self arrivals] count] == 0)
    return @"Cue sad trombone..";

  return [[[self arrivals] objectAtIndex:section] title];
}

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section
{
  if(YES == loadingBusData)
    return 1;

  if([[self arrivals] count] == 0) return 1;

  Event * event = [[self arrivals] objectAtIndex:section];

  // Only show the destination and the departure time if the bus
  // has already departed.
  if([[event distanceToGoal] intValue] < 0)
    return 2;

  return 3;
}

- (id)initWithNibName:(NSString *)nibNameOrNil
               bundle:(NSBundle *)nibBundleOrNil {
  if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
    // Initialization code
  }
  return self;
}

-    (void)alertView:(UIAlertView *)alertView
clickedButtonAtIndex:(NSInteger)buttonIndex
{
  [navController popViewControllerAnimated:YES];
}

- (void)loadView {
  [super loadView];

  baseAlert = [[UIAlertView alloc]
    initWithTitle:@"Alert"
          message:@"Oh noes! You're internets are fail!"
         delegate:self
cancelButtonTitle:nil
otherButtonTitles:@"OK", nil];

  [[self navigationItem] setRightBarButtonItem:
    [[[UIBarButtonItem alloc]
    initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh
                         target:self
                         action:@selector(refresh:)] autorelease]];
}

- (void)refresh:(id)sender
{
  [self setLoadingBusData:YES];
  [Event fetchEventsWithLocationId:[stop locationId]
                          delegate:self];
}

- (void)addFavorite:(id)sender
{
  [favoritesController createFavoriteStop:stopKey];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
  // Return YES for supported orientations
  return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)viewWillAppear:(BOOL)animated {
  [super viewWillAppear:animated];
}


- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning]; // Releases the view if it doesn't have a superview
  // Release anything that's not essential, such as cached data
}


- (void)dealloc {
  [super dealloc];
}


@end
