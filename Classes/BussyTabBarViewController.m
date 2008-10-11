//
//  BussyTabBarViewController.m
//  Bussy
//
//  Created by Aaron Patterson on 10/11/08.
//  Copyright 2008 __MyCompanyName__. All rights reserved.
//

#import "BussyTabBarViewController.h"
#import "BussyViewController.h"
#import "ArrivalsViewController.h"


@implementation BussyTabBarViewController

@synthesize busStopsController;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
	if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
		// Initialization code
	}
	return self;
}


- (void)loadView {
  NSLog(@"Load view was called");
}

/*
 If you need to do additional setup after loading the view, override viewDidLoad.
- (void)viewDidLoad {
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
