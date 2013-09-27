//
//  GGTween.m
//  Lover's Day
//
//  Created by loïc Abadie on 21/01/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "GGTween.h"
#import "GGTween_Bounce.h"
#import "GGTween_Linear.h"

@implementation GGTween
#define GGView			@"GGView"
#define GGAnim			@"GGAnim"
#define GGTWEEN_ERROR	@"Invalid TweenMode value"
#define GGTWEEN_ERRORD	@"value is invalid"
NSString* properties[] = {@"opacity", @"position", @"transform" ,@"transform.rotation.z", @"backgroundColor"};

#pragma mark tweenLogic
+ (void)tween:(CALayer*)anmView to:(GGTweenVector)toVector data:(GGTweenData)tweenData{
	id tweener;
	switch (tweenData.tweenMode) {
		case		ggTweenBounce: tweener = [GGTween_Bounce class]; break;
		case		ggTweenLinear: tweener = [GGTween_Linear class]; break;
		default:	[NSException raise: GGTWEEN_ERROR format: GGTWEEN_ERRORD];
	}
		
	[tweener tween:anmView to:toVector data:tweenData keyPath:properties[tweenData.tweenType] ];
}

GGTweenData GGTweenDataMake(float strongness,float duration,float delay, uint caAnimtag, GGTweenType tweenType,GGTweenMode tweenMode, float repeat, float repeatDuration, BOOL autoreversing){
	return (GGTweenData){strongness, duration, delay, caAnimtag, tweenType, tweenMode, repeat, repeatDuration, autoreversing};
}

GGTweenVector GGVectorMake(float na, float nb){
	return (GGTweenVector){na, nb};
}
@end
