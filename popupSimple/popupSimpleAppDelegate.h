//
//  popupSimpleAppDelegate.h
//  popupSimple
//
//  Created by sonson on 11/03/27.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class popupSimpleViewController;

@interface popupSimpleAppDelegate : NSObject <UIApplicationDelegate> {

}

@property (nonatomic, retain) IBOutlet UIWindow *window;

@property (nonatomic, retain) IBOutlet popupSimpleViewController *viewController;

@end
