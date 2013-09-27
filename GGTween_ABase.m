//
//  GGTweenABase.m
//  Lover's Day
//
//  Created by loïc Abadie on 26/01/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "GGTween_ABase.h"
@implementation GGTween_ABase
+ (void)tween:(CALayer*)layer to:(GGTweenVector)toVector data:(GGTweenData)tweenData keyPath:(NSString*)kp{
	CAKeyframeAnimation* CAKFAnimation_		= [CAKeyframeAnimation animationWithKeyPath: kp];
	CAKFAnimation_.fillMode					= kCAFillModeForwards;
	CAKFAnimation_.removedOnCompletion		= NO;
	CAKFAnimation_.duration					= tweenData.duration;
	CAKFAnimation_.beginTime				= CACurrentMediaTime() + tweenData.delay;
	CAKFAnimation_.autoreverses				= tweenData.isAutoreversing;

	if(tweenData.repeatDuration)
		CAKFAnimation_.repeatDuration		= tweenData.repeatDuration;
	else
		CAKFAnimation_.repeatCount			= tweenData.repeat;
	
	switch (tweenData.tweenType) {
		case ggTweenOpacity:	[self tweenOpacity:CAKFAnimation_ toLayer:layer withVector:toVector strongness:tweenData.strongness];					break;
		case ggTweenPosition:	[self tweenPosition:CAKFAnimation_ toPoint:layer.position withVector:toVector strongness:tweenData.strongness];			break;
		case ggTweenScale:		[self tweenScale:CAKFAnimation_ toScale:layer.frame.size withVector:toVector strongness:tweenData.strongness];									break;
		case ggTweenRotation:	[self tweenRotation:CAKFAnimation_ withVector:toVector strongness:tweenData.strongness];								break;
		case ggTweenColor:		[self tweenColor:CAKFAnimation_ withVector:toVector strongness:tweenData.strongness];								break;
	}
	[layer addAnimation:CAKFAnimation_ forKey: [NSString stringWithFormat:@"%u", tweenData.tag]];
}
@end
