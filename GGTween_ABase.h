//
//  GGTweenABase.h
//  Lover's Day
//
//  Created by loïc Abadie on 26/01/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <QuartzCore/QuartzCore.h>

typedef struct{
	float na;
	float nb;
}GGTweenVector;

typedef enum{
	ggTweenOpacity,
	ggTweenPosition,
	ggTweenScale,
	ggTweenRotation,
	ggTweenColor,
}GGTweenType;

typedef enum{
	ggTweenLinear,
	ggTweenBounce,
}GGTweenMode;

typedef struct{
	float strongness;
	float duration;
	float delay;
	uint tag;
	GGTweenType tweenType;
	GGTweenMode tweenMode;
	float repeat;
	uint repeatDuration;
	bool isAutoreversing;
}GGTweenData;

@interface GGTween_ABase : NSObject
@end

@interface GGTween_ABase(protected)
+ (void)tween:(CALayer*)layer to:(GGTweenVector)toVector data:(GGTweenData)tweenData keyPath:(NSString*)kp;
+ (void)tweenOpacity:(CAKeyframeAnimation*)anm toLayer:(CALayer*) lyr withVector:(GGTweenVector)vPt strongness:(float)stg;
+ (void)tweenPosition:(CAKeyframeAnimation*)anm toPoint:(CGPoint)pt withVector:(GGTweenVector)vPt strongness:(float)stg;
+ (void)tweenScale:(CAKeyframeAnimation*)anm toScale:(CGSize)sz withVector:(GGTweenVector)tPt strongness:(float)stg;
+ (void)tweenRotation:(CAKeyframeAnimation*)anm withVector:(GGTweenVector)tPt strongness:(float)stg;
+ (void)tweenColor:(CAKeyframeAnimation*)anm withVector:(GGTweenVector)tPt strongness:(float)stg;
@end

