//
//  BATrans.m
//  BreathAnalyser
//
//  Created by loïc Abadie on 07/04/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "BATrans.h"
#import "BAColorPicker.h"
#import "BAAllover.h"
#import "GGTween.h"

@interface BBreathTrans : UIView
@property(nonatomic, assign)id delegate;
@end

@implementation BATrans
+(void)beginTransition:(UIView*)view withDelegate:(id<BATransDelegate>)delegate{
	BBreathTrans* transView = [[BBreathTrans alloc] initWithFrame:CGRectMake(0, 0, 320, IS_IPHONE_5? 568 : 480)];
	[transView	setDelegate: delegate];
	[view		addSubview: transView];
	[transView	release];
}
@end

@interface BBreathTrans()
@end

@implementation BBreathTrans
@synthesize delegate;

#define BATransPic0			@"trans.png"
#define BATransPic1			@"trans_bb"
#define BATranPic1Total		3
#define BATranTimeDuration	1

- (void)decorate{
	BAAllover* allOver	= [[BAAllover alloc] initWithFrame: CGRectMake(0, 0, 320, IS_IPHONE_5? 568 : 480)];
	[self		insertSubview:allOver atIndex: 0];
	[allOver	release];
	
	self.frame			= CGRectMake(0, 640, 320, IS_IPHONE_5? 568 : 480);
	UIImageView* image	= [[UIImageView alloc] initWithImage: [UIImage  imageNamed: BATransPic0]];
	image.center		= CGPointMake(160, -45);
	[self	addSubview: image];
	[image	release];
	
	CGPoint centers[BATranPic1Total] = {200, 50, 80, 220, 230, 350};
	for (int i = 0; i < BATranPic1Total; i++) {
		UIImageView* timage	= [[UIImageView alloc] initWithImage: 
							   [UIImage  imageNamed: [NSString stringWithFormat:@"%@%u.png",BATransPic1, i]]];
		timage.center		= centers[i];
		[GGTween tween:timage.layer 
					to:GGVectorMake(0, 120) 
				  data:GGTweenDataMake(1, BATranTimeDuration*2, 0, 0, ggTweenRotation, ggTweenBounce, 0, 0, NO)];
		
		[GGTween tween:timage.layer 
					to:GGVectorMake(1, 1.2) 
				  data:GGTweenDataMake(1, BATranTimeDuration, 0, 2, ggTweenScale, ggTweenBounce, 3, 0, NO)];
		
		[self addSubview: timage];
		[timage release];
	}	
}

- (void)animate{
	[UIView animateWithDuration:BATranTimeDuration delay:0 options:UIViewAnimationOptionCurveEaseOut 
					 animations:^(void) {
						 self.frame = CGRectMake(0, 0, 320, IS_IPHONE_5? 568 : 480);
					 }completion:^(BOOL finished) {
						 [delegate transFinished: self];
					 }];
}

- (id)initWithFrame:(CGRect)frame{
	if((self = [super initWithFrame: frame])){
		[self decorate];
		[self animate];
		
	}
	return self;
}

- (void)drawRect:(CGRect)rect{
	CGContextRef ctx = UIGraphicsGetCurrentContext();
	CGColorRef color = [[BAColorPicker swatchColor: BAPurple] CGColor];
	CGContextSetFillColorWithColor(ctx,  color);
	CGContextFillRect(ctx, self.frame);
}
@end