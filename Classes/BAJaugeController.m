//
//  BAJaugeController.m
//  BreathAnalyser
//
//  Created by loïc Abadie on 01/04/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "BAJaugeController.h"
#import "BAJauge.h"

@interface BAJaugeController()
- (void)processDone;
@property(nonatomic, assign)float			currentBlowPulse;
@property(nonatomic, assign)BOOL			processCompleted;
@property(nonatomic, retain)BAJauge*		_jauge;
@end

@implementation BAJaugeController
@synthesize delegate,
			processCompleted,
			currentBlowPulse,
			_jauge;

#pragma mark public
- (UIView*)display{
	return _jauge;
}

- (void)blowpulse:(float)pulse{
	if(processCompleted) return;
	
	currentBlowPulse += pulse/10;
	[_jauge fulling: currentBlowPulse];
	
	if(currentBlowPulse >= 100)
		[self processDone];
};

- (void)reset{
	processCompleted = NO;
	currentBlowPulse = 0;
}

#pragma mark private
- (void)processDone{
	processCompleted = YES;
	[delegate jaugeIsFull];
}

#pragma mark alloc/dealloc
- (id)initWithDelegate:(id<BAJaugeDelegate>)delegate_{
	if((self = [super init])){
		delegate	= delegate_;
		_jauge		= [[BAJauge alloc] init];
	}
	
	return self;
}

- (void)dealloc{
	[_jauge		release];
	[super		dealloc];
}
@end
