//
//  GGTween.h
//  Lover's Day
//
//  Created by loïc Abadie on 21/01/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GGTween_ABase.h"

@interface GGTween : GGTween_ABase
+ (void)tween:(CALayer*)anmView to:(GGTweenVector)toVector data:(GGTweenData)tweenData;
GGTweenVector GGVectorMake(float na, float nb);
GGTweenData GGTweenDataMake(float strongness,float duration,float delay, uint caAnimtag, GGTweenType tweenType,GGTweenMode tweenMode, float repeat, float repeatDuration, BOOL autoreversing);
@end
