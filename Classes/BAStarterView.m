//
//  StarterView.m
//  BreathAnalyser
//
//  Created by loïc Abadie on 04/04/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//
#import <QuartzCore/QuartzCore.h>
#import "BAStarterView.h"
#import "BAPreference.h"
#import "GGTween.h"

@interface BAStarterView()
- (void)constantAnim;
- (void)badBreathAnim;
@property (nonatomic, retain)UIView* _breathes;
@end

@implementation BAStarterView
@synthesize _breathes;

typedef enum{
	BAStag_logo = 50,
	BAStag_nse,
	BAStag_mth,
	BAStag_btn,
	BAStag_wim,
	BAStag_brth,
	BAStag_lbl	= 100
}BAStarter_tag;


#pragma mark buttonAction

- (void)beforeDisplay{
	// add breathContent
	[self set_breathes: [[UIView alloc] initWithFrame: CGRectMake(0, 0, 10, 10)]];
	[self addSubview: _breathes];
	_breathes.tag = BAStag_brth;
	
	// set up font
	UILabel* startLabel		= (UILabel*)[self viewWithTag: BAStag_lbl];
	[startLabel setFont: [UIFont fontWithName: BAFontKarime size: 45]];
	startLabel.transform	= CGAffineTransformMakeRotation(M_PI * -0.06f); 
	[[startLabel layer] setRasterizationScale:[[UIScreen mainScreen] scale]];
	
	// make animation
	[self badBreathAnim];
	[self constantAnim];
}

#pragma mark animation

- (void)constantAnim{

	UIView* mouth		= [self viewWithTag: BAStag_mth];
	UIView* button		= [self viewWithTag: BAStag_btn];

	[GGTween tween:mouth.layer	to:(GGTweenVector){1.05f, .98f} data:(GGTweenData){1.f, 1.2f, 0.f, 0, ggTweenScale, ggTweenBounce, MAXFLOAT, 0, NO}];
    [GGTween tween:button.layer	to:(GGTweenVector){1.2, 1}	data:(GGTweenData){1.f, 1.2f, .6f, 0, ggTweenScale, ggTweenBounce, MAXFLOAT, 0, NO}];
}

#define BABreathImgFile @"boc.png"
#define BATotalBreathPic 7
- (void)badBreathAnim{
	NSAutoreleasePool* loop				= [[NSAutoreleasePool alloc] init];
	CGPoint points[BATotalBreathPic]	= {40, 400, 100, 410, 40, 300, 70, 350, 110, 330, 280, 320, 280, 280};
	float	size[BATotalBreathPic]		= {1, .7f, .7f, .9f, .5f, .8f, .5f};
	CGPoint	angle[BATotalBreathPic]		= {-20, -10, -20, -10, 10, 20, 20, 30, 0, 10, -60, -50, -70, -65};
	float	alpha[BATotalBreathPic]		= {1, .7f, .5f, .5f, .5f, .5f, .5f};


	for (int i = 0; i < BATotalBreathPic; i++) {
		UIImageView* breath					= [[[UIImageView alloc] initWithImage: [UIImage imageNamed: BABreathImgFile]] autorelease];
		breath.center						= points[i];
		breath.alpha						= alpha[i];
		breath.transform					= CGAffineTransformMakeScale(size[i], size[i]);
		[GGTween tween:breath.layer	to:(GGTweenVector){angle[i].x, angle[i].y}	data:(GGTweenData){1, .5f, 0, 0, ggTweenRotation, ggTweenBounce, MAXFLOAT, 0, YES}];
		//[GGTween tween:breath.layer	to:(GGTweenVector){vector[i].x, vector[i].y}	data:(GGTweenData){1, 3, 0, 1, ggTweenPosition, ggTweenLinear, MAXFLOAT}];

		[_breathes addSubview: breath];
	}
	
	[loop release];
}

- (void)drawRect:(CGRect)rect {
	CGFloat colors [] = { 
        1, 1, 1, 0, 
        1, 1, 1, .4
    };
	
    CGColorSpaceRef baseSpace	= CGColorSpaceCreateDeviceRGB();
    CGGradientRef gradient		= CGGradientCreateWithColorComponents(baseSpace, colors, NULL, 2);
    CGColorSpaceRelease(baseSpace), baseSpace = NULL;
    CGContextRef context		= UIGraphicsGetCurrentContext();
    CGContextSaveGState(context);
	
	CGPoint startPnt	= CGPointMake(160, 0);
	CGPoint endPnt		= CGPointMake(160, 480);

	CGContextDrawLinearGradient(context, 
								gradient, 
								startPnt, 
								endPnt, 
								kCGGradientDrawsBeforeStartLocation);
    CGGradientRelease(gradient), gradient = NULL;
    CGContextRestoreGState(context);
}

- (id)initWithCoder:(NSCoder *)aDecoder{
	if((self = [super initWithCoder:aDecoder])){
		[self beforeDisplay];
	}
	return self;
}

- (void)dealloc{
	[_breathes	release];
    [super		dealloc];
}

@end

