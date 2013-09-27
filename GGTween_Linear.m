//
//  GGTween_Linear.m
//  Lover's Day
//
//  Created by loïc Abadie on 26/01/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "GGTween_Linear.h"


@implementation GGTween_Linear
+ (void)tweenOpacity:(CAKeyframeAnimation*)anm toLayer:(CALayer*) lyr withVector:(GGTweenVector)vPt strongness:(float)stg{
	anm.values	= [NSArray arrayWithObjects: [NSNumber numberWithFloat:vPt.na], [NSNumber numberWithFloat: vPt.nb], nil];
}

+ (void)tweenPosition:(CAKeyframeAnimation*)anm toPoint:(CGPoint)pt withVector:(GGTweenVector)tPt strongness:(float)stg{
	CGMutablePathRef pth	= CGPathCreateMutable();
	CGPathMoveToPoint(pth, NULL, pt.x, pt.y);
	CGPathAddLineToPoint(pth, NULL, tPt.na, tPt.nb);
	anm.calculationMode		= kCAAnimationCubicPaced;
	anm.path = pth;
	CFRelease(pth);
}

+ (void)tweenScale:(CAKeyframeAnimation*)anm toScale:(CGSize)sz withVector:(GGTweenVector)tPt strongness:(float)stg{
	float scaleA = tPt.na * stg;
	float scaleB = tPt.nb * stg;
	anm.values	= [NSArray arrayWithObjects: 
				   [NSValue valueWithCATransform3D:CATransform3DMakeScale(scaleA, scaleA, 1)], 
				   [NSValue valueWithCATransform3D:CATransform3DMakeScale(scaleB, scaleB, 1)], nil];
}

+ (void)tweenRotation:(CAKeyframeAnimation*)anm withVector:(GGTweenVector)tPt strongness:(float)stg{		
	[NSException raise:@"GGTween_Linear is not ready for that kind of behavior, please overide tweenScale:::" format:@""];
}

+ (void)tweenColor:(CAKeyframeAnimation*)anm withVector:(GGTweenVector)tPt strongness:(float)stg{
	[NSException raise:@"GGTween_Linear is not ready for that kind of behavior, please overide tweenColor:::" format:@""];
}
@end
