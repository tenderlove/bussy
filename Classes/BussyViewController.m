//
//  BussyAppDelegate.m
//  Bussy
//
//  Created by Aaron Patterson on 10/9/08.
//  Copyright __MyCompanyName__ 2008. All rights reserved.
//

#import "BussyViewController.h"
#import "BussyAppDelegate.h"
#import "ArrivalsViewController.h"
#import "Stop.h"

@implementation BussyViewController

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	UITableViewCell * cell =
    [tableView dequeueReusableCellWithIdentifier:@"stops"];

	if(nil == cell)
		cell = [[[UITableViewCell alloc] initWithFrame:CGRectZero reuseIdentifier:@"stops"] autorelease];

  cell.text = [[[appDelegate stops] objectAtIndex:indexPath.row] name];
	cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
	return cell;
}

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section
{
  return [[appDelegate stops] count];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
  Stop * clickedStop = [[appDelegate stops] objectAtIndex:indexPath.row];

  [arrivalsController setStop:clickedStop];
  [arrivalsController setTitle:[clickedStop name]];

  NSString * urlString = [[NSString alloc]
    initWithFormat:@"http://ws.its.washington.edu:9090/transit/mybus/services/MybusService?method=getEventData&in0=30&in1=-10&in2=%d&in3=http%%3A%%2F%%2Ftransit.metrokc.gov", [clickedStop locationId]];

  NSURL *url = [NSURL URLWithString: urlString];

  [arrivalsController setLoadingBusData:YES];

  NSURLRequest *request = [[NSURLRequest alloc] initWithURL: url];
  NSURLConnection *connection = [[NSURLConnection alloc]
    initWithRequest:request
           delegate:arrivalsController];
  [connection release];
  [request release];

  [navController pushViewController:arrivalsController animated:YES];
}

/*
 Implement loadView if you want to create a view hierarchy programmatically
- (void)loadView {
}
 */

/*
 Implement viewDidLoad if you need to do additional setup after loading the view.
- (void)viewDidLoad {
	[super viewDidLoad];
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
