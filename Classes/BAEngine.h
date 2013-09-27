//
//  BAEngine.h
//  BreathAnalyser
//
//  Created by loïc Abadie on 16/02/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol BAEngineDelegate
- (void)InBlowDetectionChanged:(BOOL)canDetect;
- (void)blowOccuring:(float)strengh;
@end

@interface BAEngine : NSObject
- (id)initWithDelegate:(id<BAEngineDelegate>)delegate_;
- (void)startAnalysingBreath;
- (void)stopAnalysingBreath;
@property(nonatomic, assign)BOOL isDetecting;
@property(nonatomic, assign)id<BAEngineDelegate> delegate;
@end
