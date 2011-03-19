//
//  sonsonQuartzDemoViewController.m
//  sonsonQuartzDemo
//
//  Created by sonson on 11/03/15.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "sonsonQuartzDemoViewController.h"

#import "SimplePopupView.h"

@implementation sonsonQuartzDemoViewController

- (void)dealloc
{
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
	
	SimplePopupView *v = [[SimplePopupView alloc] initWithString:@"Hello, world!"];
	[self.view addSubview:v];
	
	CGRect r = v.frame;
	r.origin.x = 100;
	r.origin.y = 100;
	[v setFrame:r];
	
	[v release];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
