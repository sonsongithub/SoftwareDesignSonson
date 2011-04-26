//
//  QuartzContentView.m
//  sonsonQuartzDemo
//
//  Created by sonson on 11/03/15.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "QuartzContentView.h"

@implementation QuartzContentView

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

// simple rendering with path
- (void)drawSimpleQuad {
	CGContextRef context = UIGraphicsGetCurrentContext();
	CGContextMoveToPoint(context, 10, 10);
    CGContextAddLineToPoint(context, 20, 10);
    CGContextAddLineToPoint(context, 20, 20);
	CGContextAddLineToPoint(context, 10, 20);
	CGContextAddLineToPoint(context, 10, 10);
    CGContextClosePath(context);
    CGContextDrawPath(context, kCGPathStroke);
}

// adding path with Arc
- (void)testAddArcToPoint {
	CGContextRef context = UIGraphicsGetCurrentContext();
	
	CGPoint currentPoint = CGPointMake(100, 100);
	CGPoint point1 = CGPointMake(180, 100);
	CGPoint point2 = CGPointMake(180, 150);
	CGFloat radius = 20;
	
	CGContextMoveToPoint(context, currentPoint.x, currentPoint.y);
	CGContextAddArcToPoint(context, point1.x, point1.y, point2.x, point2.y, radius);
	CGContextAddLineToPoint(context, point2.x, point2.y);
    CGContextClosePath(context);
    CGContextDrawPath(context, kCGPathStroke);
}

// draw round corner rect
- (void)drawRoundCornerRect:(CGRect)rect mode:(CGPathDrawingMode)mode radius:(float)radius {
	CGContextRef context = UIGraphicsGetCurrentContext();
	
	CGFloat minx = CGRectGetMinX(rect), midx = CGRectGetMidX(rect), maxx = CGRectGetMaxX(rect);
	CGFloat miny = CGRectGetMinY(rect), midy = CGRectGetMidY(rect), maxy = CGRectGetMaxY(rect);
	
	CGContextMoveToPoint(context, minx, midy);
	CGContextAddArcToPoint(context, minx, miny, midx, miny, radius);
	CGContextAddArcToPoint(context, maxx, miny, maxx, midy, radius);
	CGContextAddArcToPoint(context, maxx, maxy, midx, maxy, radius);
	CGContextAddArcToPoint(context, minx, maxy, minx, midy, radius);
	CGContextClosePath(context);
    
    CGContextDrawPath(context, mode);
}

// draw with shadow
- (void)drawRectWithShadow {
	CGContextRef context = UIGraphicsGetCurrentContext();
	CGContextSaveGState(context);
	UIColor *blackColor = [UIColor blackColor];
	CGContextSetShadowWithColor (context, CGSizeMake(0, 1), 2.0, [blackColor CGColor]);
	CGContextSetRGBFillColor(context, 0.0, 1.0, 0.0, 1.0);
	CGContextFillRect(context, CGRectMake(10, 10, 100, 100));
	CGContextRestoreGState(context);
}

// draw round corner rect with shadow
- (void)drawRectWithShadow2 {
	CGContextRef context = UIGraphicsGetCurrentContext();
	CGContextSaveGState(context);
	UIColor *blackColor = [UIColor blackColor];
	CGContextSetShadowWithColor (context, CGSizeMake(0, 2), 5.0, [blackColor CGColor]);
	
	[[UIColor colorWithRed:1 green:0.6 blue:0.6 alpha:1] setFill];
	[[UIColor colorWithRed:0 green:0 blue:1 alpha:1] setStroke];
	[self drawRoundCornerRect:CGRectMake(110, 180, 100, 100) mode:kCGPathFillStroke radius:15];
	
	CGContextRestoreGState(context);
}

// clipping
- (void)testClipping {
	CGContextRef context = UIGraphicsGetCurrentContext();
	
	CGContextSaveGState(context);
	CGContextAddArc(context, 100, 100, 30, 0, 360, 0);
    CGContextClosePath(context);
	CGContextClip(context);
	
	UIColor *greenColor = [UIColor greenColor];
	CGContextSetFillColorWithColor(context, [greenColor CGColor]);
	CGContextFillRect(context, CGRectMake(100, 100, 50, 50));
	CGContextRestoreGState(context);
}

// draw with gradient color
- (void)drawGradientColor {
	CGContextRef context = UIGraphicsGetCurrentContext();
	
	// make gradient color
	CGColorSpaceRef space = CGColorSpaceCreateDeviceRGB();
	CGFloat colors[] = {
		155.0 / 255.0, 155.0 / 255.0, 155.0 / 255.0, 1.0,
		70.0 / 255.0, 70.0 / 255.0, 70.0 / 255.0, 1.0,
	};
	CGGradientRef gradient = CGGradientCreateWithColorComponents(space, colors, NULL, sizeof(colors)/(sizeof(colors[0])*4));
	CGColorSpaceRelease(space);
	
	// linear gradient
	CGContextDrawLinearGradient(context, gradient, CGPointMake(100, 100), CGPointMake(100, 200),kCGGradientDrawsBeforeStartLocation|kCGGradientDrawsAfterEndLocation);
	
	// radial gradient
	// CGContextDrawRadialGradient(context, gradient, CGPointMake(100, 100), 0, CGPointMake(100, 100), 100, 0);
	
	CGGradientRelease(gradient);
}

- (void)drawGradientRhombus {	
	CGContextRef context = UIGraphicsGetCurrentContext();
	CGColorSpaceRef space = CGColorSpaceCreateDeviceRGB();
	CGFloat colors[] = {
		155.0 / 255.0, 155.0 / 255.0, 155.0 / 255.0, 1.0,
		20.0 / 255.0, 20.0 / 255.0, 20.0 / 255.0, 1.0,
	};
	CGGradientRef gradient = CGGradientCreateWithColorComponents(space, colors, NULL, sizeof(colors)/(sizeof(colors[0])*4));
	CGColorSpaceRelease(space);
	
	CGContextSaveGState(context);
	
	CGContextMoveToPoint(context, 160,160);
    CGContextAddLineToPoint(context, 240, 240);
    CGContextAddLineToPoint(context, 160, 320);
	CGContextAddLineToPoint(context, 80, 240);
	CGContextAddLineToPoint(context, 160, 160);
    CGContextClosePath(context);
	CGContextClip(context);
	
	CGContextDrawLinearGradient(context, gradient, CGPointMake(160, 160), CGPointMake(160, 320),kCGGradientDrawsBeforeStartLocation|kCGGradientDrawsAfterEndLocation);
	
	CGGradientRelease(gradient);
	CGContextRestoreGState(context);
}

// text rendering and layout
- (void)layoutAndDrawText {
	CGContextRef context = UIGraphicsGetCurrentContext();
	
	// parameters
	CGPoint p = CGPointMake(30, 30);
	float width = 200;
	float height = 480;
	float fontSize = 20;
	
	NSString *str = @"Hello, world. Do you like iOS programming? 初めまして！iOSプログラミングはお好きですか？";
	UIColor *yellow = [UIColor yellowColor];
	UIColor *black = [UIColor blackColor];	
	UIFont *font = [UIFont boldSystemFontOfSize:fontSize];
	
	// measure size of string
	CGSize strSize = [str sizeWithFont:font constrainedToSize:CGSizeMake(width, height) lineBreakMode:UILineBreakModeCharacterWrap];
	CGRect renderingRect;
	renderingRect.origin = p;
	renderingRect.size = strSize;
	
	// render background color
	[yellow setFill];
	CGContextFillRect(context, renderingRect);
	
	// render text
	[black setFill];
	[str drawInRect:renderingRect withFont:font lineBreakMode:UILineBreakModeCharacterWrap];
}

- (void)drawText {
	NSString *str = @"Hello, world.";
	[str drawAtPoint:CGPointMake(10, 10) withFont:[UIFont boldSystemFontOfSize:12]];
}

// test antialis for comparing OpenGLES
- (void)testAntialis {
	CGContextRef context = UIGraphicsGetCurrentContext();
	
	CGContextTranslateCTM(context, 200, 200);
	CGContextRotateCTM(context, M_PI/3);
	CGContextScaleCTM(context, 0.82, 0.82);
	UIColor *color = [UIColor colorWithRed:1.0f green:0.0f blue:1.0f alpha:1.0f];
	[color setFill];
	CGContextFillRect(context, CGRectMake(-50, -50, 100, 100));
}

// draw
- (void)drawRect:(CGRect)rect {
	// Drawing code
	switch(8) {
		case 0:
			[self drawSimpleQuad];
			break;
		case 1:
			[self testAddArcToPoint];
			break;
		case 2:
			[[UIColor colorWithRed:1 green:0.6 blue:0.6 alpha:1] setFill];
			[[UIColor colorWithRed:0 green:0 blue:1 alpha:1] setStroke];
			[self drawRoundCornerRect:CGRectMake(110, 180, 100, 100) mode:kCGPathFillStroke radius:15];
			break;
		case 3:
			//[self drawRectWithShadow];
			[self drawRectWithShadow2];
			break;
		case 4:
			[self testClipping];
			break;
		case 5:
			[self drawGradientColor];
			break;
		case 6:
			[self drawGradientRhombus];
			break;
		case 7:
			[self drawText];
			break;
		case 8:
			[self layoutAndDrawText];
			break;
		case 9:
			[self testAntialis];
			break;
	}
}

- (void)dealloc {
    [super dealloc];
}

@end
