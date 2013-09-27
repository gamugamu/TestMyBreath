//
//  BASkullLayer.m
//  BreathAnalyser
//
//  Created by loïc Abadie on 13/05/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "BASkullLayer.h"
#import "GGTween.h"

@implementation BASkullLayer
- (void)setup_skulls{
	UIImageView* skull0 = [[UIImageView alloc] initWithImage: [UIImage imageNamed: @"allOver0.png"]];
	UIImageView* skull1 = [[UIImageView alloc] initWithImage: [UIImage imageNamed: @"allOver0.png"]];
	UIImageView* skull2 = [[UIImageView alloc] initWithImage: [UIImage imageNamed: @"allOver0.png"]];
	UIImageView* skull3 = [[UIImageView alloc] initWithImage: [UIImage imageNamed: @"allOver0.png"]];

	[self addSubview: skull0];
	[self addSubview: skull1];
	[self addSubview: skull2];
	[self addSubview: skull3];

	skull0.center = CGPointMake(50, 100);
	skull1.center = CGPointMake(100, 200);
	skull2.center = CGPointMake(50, 300);
	skull3.center = CGPointMake(100, 400);

	[skull0 release];
	[skull1 release];
	[skull2 release];
	[skull3 release];
	NSLog(@"add");
}

- (id)initWithFrame:(CGRect)frame{
    if (( self = [super initWithFrame:frame])) {
		[self setup_skulls];
    }
    return self;
}

- (void)dealloc{
    [super dealloc];
}

@end
