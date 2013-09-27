//
//  GGMicRecorder.h
//  BreathAnalyser
//
//  Created by loïc Abadie on 16/02/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AudioToolbox/AudioToolbox.h>
#import <AVFoundation/AVFoundation.h>

@protocol GGLowMicRecorderDelegate
- (void)inputIsAvailableChanged:(BOOL)isInputAvailable;
- (void)currentMeterState:(AudioQueueLevelMeterState)aqlms;
@end

@interface GGLowMicRecorder:NSObject
- (id)initWithDelegate:(id <GGLowMicRecorderDelegate>)delegate_ andSetting:(AudioStreamBasicDescription)settings;
- (BOOL)askInputAvailability;
- (void)recordTo:(NSURL*)urlPath;
- (void)stop:(BOOL)wantSave;
@property(nonatomic, assign)id<GGLowMicRecorderDelegate>	delegate;
@property(nonatomic, assign) BOOL							isRecording;
@end
