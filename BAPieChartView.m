//
//  BAPieChartView.m
//  BreathAnalyser
//
//  Created by loïc Abadie on 29/03/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "BAPieChartView.h"
#import "BAPieLayer.h"
#import "BAAnalyser.h"
#import "BAColorPicker.h"

@interface BAPieChartView()
- (void)makeFragment:(NSDictionary*)pieData;
- (void)addGradient;
@property(nonatomic, assign)float rSize;
@end

@implementation BAPieChartView
@synthesize rSize;

#define GGPIE 3.1416

- (void)drawRect:(CGRect)rect{}

- (void)drawLayer:(CALayer *)layer inContext:(CGContextRef)ctx{
	CGSize position		= self.frame.size;
	float x				= position.width / 2;
    float y				= position.height / 2;
    float r				= rSize;
	const CGFloat* cmp	= CGColorGetComponents([[BAColorPicker swatchColor: BAPurple] CGColor]);	
	
	CGContextSetRGBStrokeColor(ctx, cmp[0], cmp[1], cmp[2], cmp[3]);
    CGContextSetLineWidth(ctx, 15);
    CGContextAddArc(ctx, x, y, r, 0.0, 360.0*GGPIE /180.0, 0);
    CGContextClosePath(ctx);
    CGContextDrawPath(ctx, kCGPathStroke);
}

- (void)makeFragment:(NSDictionary*)pieData{
	__block float lastRad	= 0; 

	[pieData enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
		float radSize		= 360.f/(100.f / [obj floatValue]) + lastRad;
		BAPieLayer* layer   = [[BAPieLayer alloc] initWithPercent: CGPointMake(lastRad, radSize) 
														andColors: [BAColorPicker swatchColor: [key intValue]]];
		CGSize cFrame		= self.frame.size;
		layer.frame			= CGRectMake(0, 0, cFrame.width, cFrame.height);
		layer.rSize			= rSize;
		lastRad				= radSize;
        [[self layer]       addSublayer:layer];
        [layer              setNeedsDisplay];
        [layer              release];
	}];
	
}

- (void)addGradient{
	UIImageView* gradient = [[UIImageView alloc] initWithImage: [UIImage imageNamed:@"pieGloss"]];
	CGPoint pos		= self.center;
	gradient.center = (CGPoint){pos.x - 13, pos.y - 103};
	[self		addSubview: gradient];
	[gradient	release];
}

#pragma mark alloc/dealloc
- (id)initWithPieData:(NSDictionary*)percentData andRayonSize:(float)rSize_ intoFrame:(CGRect)frame{
    if((self = [super initWithFrame:frame])){
		self.backgroundColor = [UIColor clearColor];
		rSize = rSize_;
        [self makeFragment: percentData];
		[self addGradient];
    }
    return self;
}

- (void)dealloc{
    [super dealloc];
}

@end
