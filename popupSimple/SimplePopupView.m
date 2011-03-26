//
//  SimplePopupView.m
//  popupSimple
//
//  Created by sonson on 11/03/27.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "SimplePopupView.h"


@implementation SimplePopupView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

// draw round corner rect
- (void)setPathRoundCornerRect:(CGRect)rect radius:(float)radius {
	CGContextRef context = UIGraphicsGetCurrentContext();
	
	CGFloat minx = CGRectGetMinX(rect), midx = CGRectGetMidX(rect), maxx = CGRectGetMaxX(rect);
	CGFloat miny = CGRectGetMinY(rect), midy = CGRectGetMidY(rect), maxy = CGRectGetMaxY(rect);
	
	CGContextMoveToPoint(context, minx, midy);
	CGContextAddArcToPoint(context, minx, miny, midx, miny, radius);
	CGContextAddArcToPoint(context, maxx, miny, maxx, midy, radius);
	CGContextAddArcToPoint(context, maxx, maxy, midx, maxy, radius);
	CGContextAddArcToPoint(context, minx, maxy, minx, midy, radius);
	CGContextClosePath(context);
}

// draw round corner rect
- (void)drawBackgroundWithShadowRect:(CGRect)rect {
	CGContextRef context = UIGraphicsGetCurrentContext();
	
	CGContextSaveGState(context);
	UIColor *blackColor = [UIColor blackColor];
	CGContextSetShadowWithColor (context, CGSizeMake(0, 2), 5.0, [blackColor CGColor]);
	
	float radius = 5;
	
	CGFloat minx = CGRectGetMinX(rect), midx = CGRectGetMidX(rect), maxx = CGRectGetMaxX(rect);
	CGFloat miny = CGRectGetMinY(rect), midy = CGRectGetMidY(rect), maxy = CGRectGetMaxY(rect);
	
	CGContextMoveToPoint(context, minx, midy);
	CGContextAddArcToPoint(context, minx, miny, midx, miny, radius);
	CGContextAddArcToPoint(context, maxx, miny, maxx, midy, radius);
	CGContextAddArcToPoint(context, maxx, maxy, midx, maxy, radius);
	
	CGContextAddLineToPoint(context, midx+10, maxy);
	CGContextAddLineToPoint(context, midx, maxy+10);
	CGContextAddLineToPoint(context, midx-10, maxy);
	
	CGContextAddArcToPoint(context, minx, maxy, minx, midy, radius);
	CGContextClosePath(context);
    
	[[UIColor colorWithRed:0.2 green:0.2 blue:0.2 alpha:1] setFill];
    CGContextDrawPath(context, kCGPathFill);
	
	CGContextRestoreGState(context);
}

// draw round corner rect
- (void)drawBackgroundRect:(CGRect)rect {
	CGContextRef context = UIGraphicsGetCurrentContext();
	
	float radius = 5;
	
	CGFloat minx = CGRectGetMinX(rect), midx = CGRectGetMidX(rect), maxx = CGRectGetMaxX(rect);
	CGFloat miny = CGRectGetMinY(rect), midy = CGRectGetMidY(rect), maxy = CGRectGetMaxY(rect);
	
	CGContextMoveToPoint(context, minx, midy);
	CGContextAddArcToPoint(context, minx, miny, midx, miny, radius);
	CGContextAddArcToPoint(context, maxx, miny, maxx, midy, radius);
	CGContextAddArcToPoint(context, maxx, maxy, midx, maxy, radius);
	
	CGContextAddLineToPoint(context, midx+10, maxy);
	CGContextAddLineToPoint(context, midx, maxy+10);
	CGContextAddLineToPoint(context, midx-10, maxy);
	
	CGContextAddArcToPoint(context, minx, maxy, minx, midy, radius);
	CGContextClosePath(context);
    
	[[UIColor colorWithRed:0.2 green:0.2 blue:0.2 alpha:1] setFill];
    CGContextDrawPath(context, kCGPathFill);
}

- (void)drawGrowlRect:(CGRect)rect {
	CGContextRef context = UIGraphicsGetCurrentContext();
	
	CGContextSaveGState(context);
	[self setPathRoundCornerRect:rect radius:5];
	CGContextClip(context);
	
	// make gradient color
	CGColorSpaceRef space = CGColorSpaceCreateDeviceRGB();
	CGFloat colors[] = {
		255.0 / 255.0, 255.0 / 255.0, 255.0 / 255.0, 0.6,
		255.0 / 255.0, 255.0 / 255.0, 255.0 / 255.0, 0.2,
	};
	CGGradientRef gradient = CGGradientCreateWithColorComponents(space, colors, NULL, sizeof(colors)/(sizeof(colors[0])*4));
	CGColorSpaceRelease(space);
	
	float s = rect.origin.y;
	float e = rect.origin.y + rect.size.height/2;
	
	// linear gradient
	CGContextDrawLinearGradient(context, gradient, CGPointMake(0, s), CGPointMake(0, e), 0);
	
	// radial gradient
	// CGContextDrawRadialGradient(context, gradient, CGPointMake(100, 100), 0, CGPointMake(100, 100), 100, 0);
	
	CGGradientRelease(gradient);
	
	CGContextRestoreGState(context);
}

- (void)drawTitleInRect:(CGRect)rect {
	CGContextRef context = UIGraphicsGetCurrentContext();
	float fontSize = 20;
	NSString *str = @"Hello, world!";
	UIFont *font = [UIFont boldSystemFontOfSize:fontSize];
	
//	// parameters
//	CGPoint p = CGPointMake(30, 30);
//	float width = 200;
//	float height = 480;
//	float fontSize = 20;
//	
//	NSString *str = @"Hello, world!";
//	UIColor *yellow = [UIColor yellowColor];
//	UIColor *black = [UIColor blackColor];	
//	UIFont *font = [UIFont boldSystemFontOfSize:fontSize];
//	
	// measure size of string
	CGSize strSize = [str sizeWithFont:font constrainedToSize:CGSizeMake(rect.size.width, rect.size.height) lineBreakMode:UILineBreakModeCharacterWrap];
	CGRect renderingRect;
	renderingRect.size = strSize;
	renderingRect.origin = CGPointMake((rect.size.width - strSize.width)/2 + rect.origin.x, (rect.size.height - strSize.height)/2 + rect.origin.y);
	
	
	CGContextSaveGState(context);
	UIColor *blackColor = [UIColor blackColor];
	CGContextSetShadowWithColor (context, CGSizeMake(0, -1), 1, [blackColor CGColor]);
	
	// render text
	[[UIColor whiteColor] setFill];
//	[str drawInRect:rect withFont:font lineBreakMode:UILineBreakModeCharacterWrap];
	[str drawAtPoint:renderingRect.origin withFont:font];
	
	CGContextRestoreGState(context);
}

- (void)drawRect:(CGRect)rect {
    // Drawing code;
	CGRect r = CGRectMake(85, 210, 150, 40);
	
	[self drawBackgroundWithShadowRect:r];
	
	[self drawGrowlRect:r];
	
	[self drawTitleInRect:r];
	
//	[self drawBackgroundRect:r];
}

- (void)dealloc
{
    [super dealloc];
}

@end
