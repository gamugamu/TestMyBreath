//
//  BAPieLayer.m
//  BreathAnalyser
//
//  Created by loïc Abadie on 30/03/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "BAPieLayer.h"

@implementation BAPieLayer
@synthesize degPercent,
			rSize,
			_color;

- (void)drawInContext:(CGContextRef)ctx{
	CGSize position		= self.frame.size;
	float x				= position.width / 2;
    float y				= position.height / 2;
    float r				= rSize;
    float startDeg		= degPercent.x;
    float endDeg		= degPercent.y;
	const CGFloat* cmp	= CGColorGetComponents(_color.CGColor);	

	CGContextSetInterpolationQuality(ctx, kCGInterpolationHigh);
	CGContextSetRGBStrokeColor(ctx, cmp[0], cmp[1], cmp[2], cmp[3]);
    CGContextSetLineWidth(ctx, .1);
    CGContextMoveToPoint(ctx, x, y);
    CGContextAddArc(ctx, x, y, r, (startDeg-90)*M_PI/180.0, (endDeg-90)*M_PI/180.0, 0);
    CGContextClosePath(ctx);
    CGContextDrawPath(ctx, kCGPathStroke);
    CGContextSetRGBFillColor(ctx,  cmp[0], cmp[1], cmp[2], cmp[3]);
    CGContextMoveToPoint(ctx, x, y);
    CGContextAddArc(ctx, x, y, r, (startDeg-90)*M_PI/180.0, (endDeg-90)*M_PI/180.0, 0);
    CGContextClosePath(ctx);
    CGContextFillPath(ctx);
	CGContextStrokePath(ctx);
}

#pragma mark alloc/dealloc
- (id)initWithPercent:(CGPoint)degPercent_ andColors:(UIColor*)color_{
	if((self = [super init])){
		degPercent = degPercent_;
		[self set_color: color_];
		[self setRasterizationScale: [[UIScreen mainScreen] scale]];
		self.contentsScale	= [[UIScreen mainScreen] scale];
	}
	return self;
}

- (void)dealloc{
	[_color release];
	[super	dealloc];
}
@end
