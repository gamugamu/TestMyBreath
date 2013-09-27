//
//  BAEngine.m
//  BreathAnalyser
//
//  Created by loïc Abadie on 16/02/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "BAEngine.h"
#import "GGLowMicRecorder.h"

@interface BAEngine()<GGLowMicRecorderDelegate, AVAudioSessionDelegate>
- (void)setMicRecorder;
@property(nonatomic, retain)GGLowMicRecorder* _recorderEngine;
@property(nonatomic, assign)BOOL blowrequestAsked;
@end

@implementation BAEngine
@synthesize _recorderEngine,
			isDetecting,
			blowrequestAsked,
			delegate;

#pragma mark public
- (void)startAnalysingBreath{
	isDetecting			= [_recorderEngine askInputAvailability];
	blowrequestAsked	= YES;
	
	if(isDetecting)
		[_recorderEngine recordTo: nil];
	else
		[self inputIsAvailableChanged:NO];
}

- (void)stopAnalysingBreath{
	isDetecting			= NO;
	blowrequestAsked	= NO;
	[_recorderEngine stop: NO];
}

#pragma mark micDelegate
#define micThresold -10
- (void)currentMeterState:(AudioQueueLevelMeterState)aqlms{
	if (aqlms.mAveragePower > micThresold && !aqlms.mPeakPower){
		float strenghInPercent = 100 - micThresold * aqlms.mAveragePower / 1;
		[delegate blowOccuring: strenghInPercent];
	}	
}

- (void)inputIsAvailableChanged:(BOOL)isInputAvailable{
	if(blowrequestAsked){
		if(isInputAvailable) [self startAnalysingBreath];
		[delegate InBlowDetectionChanged: isInputAvailable];
	}
}

#pragma mark conf
- (void)setMicRecorder{
	AudioStreamBasicDescription	dataFormat;
	dataFormat.mSampleRate			= 44100.0f;
	dataFormat.mFormatID			= kAudioFormatLinearPCM;
	dataFormat.mFramesPerPacket		= 1;
	dataFormat.mChannelsPerFrame	= 1;
	dataFormat.mBytesPerFrame		= 2;
	dataFormat.mBytesPerPacket		= 2;
	dataFormat.mBitsPerChannel		= 16;
	dataFormat.mReserved			= 0;
	dataFormat.mFormatFlags			=	kLinearPCMFormatFlagIsBigEndian		| 
										kLinearPCMFormatFlagIsSignedInteger | 
										kLinearPCMFormatFlagIsPacked;
	
	_recorderEngine = [[GGLowMicRecorder alloc] initWithDelegate:self andSetting:dataFormat];
}

#pragma mark aloc/dealloc
- (id)initWithDelegate:(id<BAEngineDelegate>)delegate_{
	if ((self = [super init])) {
		delegate = delegate_;
		[self setMicRecorder];
	}
	return self;
}

- (void)dealloc{
	[_recorderEngine	release];
	[super				dealloc];
}
@end
