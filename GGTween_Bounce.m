//
//  GGTween_Bounce.m
//  Lover's Day
//
//  Created by loïc Abadie on 26/01/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "GGTween_Bounce.h"

@implementation GGTween_Bounce
+ (void)tweenOpacity:(CAKeyframeAnimation*)anm toLayer:(CALayer*)lyr withVector:(GGTweenVector)vPt strongness:(float)stg{
	anm.values	= [NSArray arrayWithObjects: 
				   [NSNumber numberWithFloat:vPt.na], 
				   [NSNumber numberWithFloat: 1 - (vPt.nb + vPt.na/1.2)* stg],
				   [NSNumber numberWithFloat:1 - (vPt.nb + vPt.na/2 )* stg],
				   [NSNumber numberWithFloat: vPt.nb], nil];
}

+ (void)tweenScale:(CAKeyframeAnimation*)anm toScale:(CGSize)sz withVector:(GGTweenVector)tPt strongness:(float)stg{
	float	scaleA	= tPt.na * stg;
	float	scaleB	= tPt.nb * stg;
	
	anm.values	= [NSArray arrayWithObjects: 
				   [NSValue valueWithCATransform3D:CATransform3DMakeScale(1, 1, 1)],
				   [NSValue valueWithCATransform3D:CATransform3DMakeScale(scaleA, scaleA, 1)], 
				   [NSValue valueWithCATransform3D:CATransform3DMakeScale(scaleB, scaleB, 1)], 
				   [NSValue valueWithCATransform3D:CATransform3DMakeScale(1, 1, 1)], nil];	
}

+ (void)tweenPosition:(CAKeyframeAnimation*)anm toPoint:(CGPoint)pt withVector:(GGTweenVector)tPt strongness:(float)stg{
 	CGMutablePathRef pth	= CGPathCreateMutable();
	GGTweenVector vct		= {(tPt.na - pt.x) * stg, (tPt.nb - pt.y) * stg};
	CGPathMoveToPoint(pth, NULL, pt.x, pt.y);
	CGPathAddLineToPoint(pth, NULL, tPt.na + vct.na, tPt.nb + vct.nb);
	CGPathAddLineToPoint(pth, NULL, tPt.na - vct.na, tPt.nb - vct.nb);
	CGPathAddLineToPoint(pth, NULL, tPt.na, tPt.nb);
	anm.calculationMode		= kCAAnimationCubicPaced;
	anm.path = pth;
	CFRelease(pth);
}

+ (void)tweenRotation:(CAKeyframeAnimation*)anm withVector:(GGTweenVector)tPt strongness:(float)stg{		
	anm.calculationMode = kCAAnimationPaced;
	
	[anm setTimingFunctions: [NSArray arrayWithObjects:
							  [CAMediaTimingFunction functionWithName: kCAMediaTimingFunctionLinear],
							  [CAMediaTimingFunction functionWithName: kCAMediaTimingFunctionEaseIn],
							  [CAMediaTimingFunction functionWithName: kCAMediaTimingFunctionEaseOut],nil]];

	float rad = 360/(M_PI*2);
	anm.values = [NSArray arrayWithObjects:
				  [NSNumber numberWithFloat: tPt.na/rad],
				  [NSNumber numberWithFloat: tPt.nb/rad], nil];
}

+ (void)tweenColor:(CAKeyframeAnimation*)anm withVector:(GGTweenVector)tPt strongness:(float)stg{
	[NSException raise:@"GGTween_Linear is not ready for that kind of behavior, please overide tweenColor:::" format:@""];
}
@end
