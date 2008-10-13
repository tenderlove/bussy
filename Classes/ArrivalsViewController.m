//
//  BusStopViewController.m
//  Bussy
//
//  Created by Aaron Patterson on 10/9/08.
//  Copyright 2008 __MyCompanyName__. All rights reserved.
//

#import "ArrivalsViewController.h"
#import "Stop.h"


@implementation ArrivalsViewController

@synthesize arrivals;
@synthesize stop;

- (void)setArrivals:(NSArray *)a
{
	[arrivals release];
	arrivals = [a retain];
	[tableView reloadData];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
  NSLog(responseData);
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

  NSLog (@"connectionDidReceiveData");
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
	UITableViewCell * cell = [tv dequeueReusableCellWithIdentifier:@"arrival"];
	if(nil == cell)
		cell = [[[UITableViewCell alloc] initWithFrame:CGRectZero reuseIdentifier:@"arrival"] autorelease];
	
	cell.text = [[self arrivals] objectAtIndex:indexPath.row];
	
	return cell;
}

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section
{
	return [[self arrivals] count];
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
