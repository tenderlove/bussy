//
//  BusStopViewController.m
//  Bussy
//
//  Created by Aaron Patterson on 10/9/08.
//  Copyright 2008 __MyCompanyName__. All rights reserved.
//

#import "ArrivalsViewController.h"
#import "Stop.h"
#import "EventBuilder.h"
#import "Event.h"


@implementation ArrivalsViewController

@synthesize arrivals;
@synthesize stop;
@synthesize loadingBusData;

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
  [self setArrivals:[EventBuilder fromXML:responseData]];
}

- (void)connection:(NSURLConnection *)connection
  didFailWithError:(NSError *)error
{
  NSLog(@"FUCK: %@", error);
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
  NSArray * components;

  if(YES == loadingBusData)
    return [self loadingCell];

  if([[self arrivals] count] == 0)
    return [self noArrivalsCell];

	UITableViewCell * cell = [tv dequeueReusableCellWithIdentifier:@"arrival"];
	if(nil == cell)
		cell = [[[UITableViewCell alloc] initWithFrame:CGRectZero reuseIdentifier:@"arrival"] autorelease];
	
  Event * event = [[self arrivals] objectAtIndex:indexPath.section];
  switch(indexPath.row)
  {
    case 0:
      components = [[event destination] componentsSeparatedByString:@" - "];
      if([components count] > 1) {
        cell.text = [components objectAtIndex:1];
      } else
        cell.text = [event destination];
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

  NSString * dest = [[[self arrivals] objectAtIndex:section] destination];
  NSArray * components = [dest componentsSeparatedByString:@" - "];
  return (NSString *)[components objectAtIndex:0];
}

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section
{
  return 1;
  /*
  if(YES == loadingBusData)
    return 1;

  if([[self arrivals] count] == 0) return 1;

	return [[self arrivals] count];
  */
}

- (id)initWithNibName:(NSString *)nibNameOrNil
               bundle:(NSBundle *)nibBundleOrNil {
	if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
		// Initialization code
	}
	return self;
}

/*
 Implement loadView if you want to create a view hierarchy programmatically
- (void)loadView {
}
 */

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
	// Return YES for supported orientations
	return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning]; // Releases the view if it doesn't have a superview
	// Release anything that's not essential, such as cached data
}


- (void)dealloc {
	[super dealloc];
}


@end
