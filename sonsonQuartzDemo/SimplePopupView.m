//
//  SimplePopupView.m
//  sonsonQuartzDemo
//
//  Created by sonson on 11/03/19.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "SimplePopupView.h"


@implementation SimplePopupView

- (id)initWithString:(NSString*)aMessage {
	CGRect rect = CGRectZero;
	self = [super initWithFrame:rect];
	
	if (self) {
		font = [[UIFont boldSystemFontOfSize:18] retain];
		message = [aMessage copy];
		
		// parameters
		float width = 240;
		float height = 44;
		
		rootHeight = 20;
		
		float h_margin = 20;
		float v_margin = 20;
		
		// measure size of string
		CGSize strSize = [message sizeWithFont:font constrainedToSize:CGSizeMake(width, height) lineBreakMode:UILineBreakModeCharacterWrap];
		
		contentRect.origin.x = h_margin / 2;
		contentRect.origin.y = v_margin / 2;
		contentRect.size = strSize;
		
		// add margin
		strSize.width += h_margin;
		strSize.height = strSize.height + v_margin + rootHeight;
		
		rect.size = strSize;
		
		
		// initialize self
		
		// set background color
		self.backgroundColor = [UIColor clearColor];
		
		[self setFrame:rect];
		
		CGColorSpaceRef rgb = CGColorSpaceCreateDeviceRGB();
		
		
		CGFloat colors[] =
		{
			155.0 / 255.0, 155.0 / 255.0, 155.0 / 255.0, 0.6,
			70.0 / 255.0, 70.0 / 255.0, 70.0 / 255.0, 0.6,
		};
		gradient = CGGradientCreateWithColorComponents(rgb, colors, NULL, sizeof(colors)/(sizeof(colors[0])*4));
		
		CGFloat colors2[] =
		{
			20.0 / 255.0, 20.0 / 255.0, 20.0 / 255.0, 0.6,
			255.0 / 255.0, 255.0 / 255.0, 0.0 / 255.0, 0.6,
		};
		gradient2 = CGGradientCreateWithColorComponents(rgb, colors2, NULL, sizeof(colors2)/(sizeof(colors2[0])*4));
		CGColorSpaceRelease(rgb);
	}
	return self;
}

- (void)drawGrowl {
	CGContextRef context = UIGraphicsGetCurrentContext();
	
	CGContextSaveGState(context);
	CGRect rect = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height - 10);
	
	rect.origin.y += 1;
	rect.origin.x += 1;
	rect.size.width -= 2;
	
	float radius = 10;
	
    // get points
    CGFloat minx = CGRectGetMinX( rect ), midx = CGRectGetMidX( rect ), maxx = CGRectGetMaxX( rect );
    CGFloat miny = CGRectGetMinY( rect ), midy = CGRectGetMidY( rect ), maxy = CGRectGetMaxY( rect );
	
	maxy = 0; // for compiler warning
	
	CGFloat rightEdgeX = minx;
	CGFloat rightEdgeY = midy - rootHeight;
	
	CGFloat leftEdgeX = maxx;
	CGFloat leftEdgeY = midy - rootHeight;
	
    CGContextMoveToPoint(context, rightEdgeX, rightEdgeY);
    CGContextAddArcToPoint(context, minx, miny, midx, miny, radius);
    CGContextAddArcToPoint(context, maxx, miny, maxx, midy, radius);
    CGContextAddLineToPoint(context, leftEdgeX, leftEdgeY);
	
	CGSize POPUP_ROOT_SIZE = CGSizeMake(20, 5);
	
	CGContextClip(context);
	
	CGContextDrawLinearGradient(context, gradient, CGPointMake(0, rect.origin.y), CGPointMake(0, rect.origin.y + (int)(rect.size.height-POPUP_ROOT_SIZE.height)/2), 0);
	CGContextDrawLinearGradient(context, gradient2, CGPointMake(0, rect.origin.y + (int)(rect.size.height-POPUP_ROOT_SIZE.height)/2), CGPointMake(0, rect.origin.y + rect.size.height-POPUP_ROOT_SIZE.height), 0);
	CGContextRestoreGState(context);
}

- (void)drawPopupBase {
	CGContextRef context = UIGraphicsGetCurrentContext();
	
	
	CGContextSaveGState(context);
	
	CGContextSetRGBFillColor(context, 0.1, 0.1, 0.1, 0.6);
	CGContextSetShadowWithColor (context, CGSizeMake(0, 2), 2, [[UIColor colorWithRed:0 green:0 blue:0 alpha:0.5] CGColor]);

	
	float radius = 10;
	
	CGPoint popPoint = CGPointMake(self.frame.size.width/2, self.frame.size.height);
	
	CGRect rect = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height - rootHeight);
	
	// get points
	CGFloat minx = CGRectGetMinX( rect ), midx = CGRectGetMidX( rect ), maxx = CGRectGetMaxX( rect );
	CGFloat miny = CGRectGetMinY( rect ), midy = CGRectGetMidY( rect ), maxy = CGRectGetMaxY( rect );
	
	CGFloat popRightEdgeX = popPoint.x + (int)20 / 2;
	CGFloat popRightEdgeY = maxy;
	
	CGFloat popLeftEdgeX = popPoint.x - (int)20 / 2;
	CGFloat popLeftEdgeY = maxy;
	CGContextMoveToPoint(context, minx, midy);
	CGContextAddArcToPoint(context, minx, miny, midx, miny, radius);
	CGContextAddArcToPoint(context, maxx, miny, maxx, midy, radius);
	
	CGContextAddArcToPoint(context, maxx, maxy, popRightEdgeX, popRightEdgeY, radius);
	CGContextAddLineToPoint(context, popRightEdgeX, popRightEdgeY);
	CGContextAddLineToPoint(context, popPoint.x, popPoint.y);
	CGContextAddLineToPoint(context, popLeftEdgeX, popLeftEdgeY);
	CGContextAddArcToPoint(context, minx, maxy, minx, midy, radius);
	CGContextAddLineToPoint(context, minx, midy);
	
	CGContextClosePath(context);
	CGContextFillPath(context);
	CGContextRestoreGState(context);
}

- (void)drawMessage {
	CGContextRef context = UIGraphicsGetCurrentContext();
	CGContextSetRGBFillColor(context, 1, 1, 1, 1);
	[message drawInRect:contentRect withFont:font];
}

- (void)drawRect:(CGRect)rect {
	[self drawPopupBase];
	
	[self drawGrowl];
	
	[self drawMessage];
}

- (void)dealloc {
	[message release];
	[font release];
    [super dealloc];
}

@end
