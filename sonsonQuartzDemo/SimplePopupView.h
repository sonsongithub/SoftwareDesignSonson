//
//  SimplePopupView.h
//  sonsonQuartzDemo
//
//  Created by sonson on 11/03/19.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface SimplePopupView : UIView {
    UIFont		*font;
	NSString	*message;
	CGGradientRef gradient;
	CGGradientRef gradient2;
	CGRect		contentRect;
	float rootHeight;
}
- (id)initWithString:(NSString*)aMessage;
@end
