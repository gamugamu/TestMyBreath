//
//  GGMicRecorder.m
//  BreathAnalyser
//
//  Created by loïc Abadie on 16/02/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//
#import "GGLowMicRecorder.h"

// TODO: adding/removing Listener, clean Data when creating buffer, etc...

void cb_audioInput(void* inUserData, AudioQueueRef inAQ, AudioQueueBufferRef inBuffer, const AudioTimeStamp *inStartTime, UInt32 inNumberPacketDescriptions, const AudioStreamPacketDescription *inPacketDescs);

@interface GGLowMicRecorder()
- (void)makeQueue;
- (void)currentPAPower;
@property(nonatomic, assign) AudioStreamBasicDescription	dataFormat;
@property(nonatomic, assign) AudioQueueRef					queue;
@property(nonatomic, assign) AudioFileID					audioFile;
@property(nonatomic, assign) SInt64							currentPacket;
@property(nonatomic, assign) NSString*						recordFile;
@end

@implementation GGLowMicRecorder
@synthesize dataFormat,
			queue,
			audioFile,
			currentPacket,
			recordFile,
			isRecording,
			delegate;


#pragma mark public
- (void)recordTo:(NSURL*)urlPath{	
	if(![[AVAudioSession sharedInstance] inputIsAvailable]) return;

	if(AudioQueueNewInput(&dataFormat,
						  cb_audioInput,
						  self,
						  CFRunLoopGetCurrent(),
						  kCFRunLoopCommonModes,
						  0,
						  &queue) == noErr)
	{
    }
	
	UInt32 enabledLevelMeter	= YES;
	AudioQueueSetProperty(queue, kAudioQueueProperty_EnableLevelMetering, &enabledLevelMeter, sizeof(UInt32));
    AudioSessionInitialize(NULL, NULL, NULL, NULL);
    UInt32 category = kAudioSessionCategory_PlayAndRecord;
    AudioSessionSetProperty(kAudioSessionProperty_AudioCategory, sizeof(category), &category);
    AudioSessionSetActive(YES);
    
	isRecording					= YES;
	[self makeQueue];
}

- (void)stop:(BOOL)wantSave{
	if(!isRecording)
        return;
	
    isRecording = NO;
	AudioQueueStop (queue,YES);
	AudioQueueDispose (queue, YES);
}

#pragma mark private
void cb_audioInput(void* inUserData,
				   AudioQueueRef inAQ,
				   AudioQueueBufferRef inBuffer,
				   const AudioTimeStamp *inStartTime,
				   UInt32 inNumberPacketDescriptions,
		const AudioStreamPacketDescription *inPacketDescs){
	GGLowMicRecorder* recorder = (GGLowMicRecorder*)inUserData;

	if(recorder.isRecording){
		AudioFileWritePackets(recorder.audioFile,
							  NO, 
							  inBuffer->mAudioDataByteSize,
							  inPacketDescs,
							  recorder.currentPacket,
							  &inNumberPacketDescriptions,
							  inBuffer->mAudioData);
		recorder.currentPacket += inNumberPacketDescriptions;
	}
	
	[recorder currentPAPower];
    AudioQueueEnqueueBuffer(inAQ, inBuffer, 0, NULL);
}

- (void)currentPAPower{
	AudioQueueLevelMeterState levelMeter;
	UInt32 levelMeterSize = sizeof(AudioQueueLevelMeterState);
	AudioQueueGetProperty(queue, kAudioQueueProperty_CurrentLevelMeterDB, &levelMeter, &levelMeterSize);

	[delegate currentMeterState:levelMeter];
}

#pragma mark setDataFormat
#define b_size 3
AudioQueueBufferRef buffers[b_size];
- (void)makeQueue{
	for(int i=0; i<b_size; i++){
		AudioQueueAllocateBuffer(queue, (dataFormat.mSampleRate/10.0f)*dataFormat.mBytesPerFrame, &buffers[i]);
		AudioQueueEnqueueBuffer(queue, buffers[i], 0, nil);
	}

	AudioQueueStart(queue, NULL);
}

#pragma mark delegate
- (BOOL)askInputAvailability{
	return  [[AVAudioSession sharedInstance] inputIsAvailable];
}

#pragma mark alloc/dealloc
- (id)initWithDelegate:(id<GGLowMicRecorderDelegate>)delegate_ andSetting:(AudioStreamBasicDescription)settings{
	if ((self = [super init])) {
		delegate						= delegate_;
		dataFormat						= settings;
		//[[AVAudioSession sharedInstance] setDelegate: delegate];
	}
	return self;
}
@end
