//
//  sonsonQuartzDemoAppDelegate.h
//  sonsonQuartzDemo
//
//  Created by sonson on 11/03/15.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class sonsonQuartzDemoViewController;

@interface sonsonQuartzDemoAppDelegate : NSObject <UIApplicationDelegate> {

}

@property (nonatomic, retain) IBOutlet UIWindow *window;

@property (nonatomic, retain) IBOutlet sonsonQuartzDemoViewController *viewController;

@end
