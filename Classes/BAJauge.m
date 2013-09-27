//
//  BAJauge.m
//  BreathAnalyser
//
//  Created by loïc Abadie on 01/04/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "BAJauge.h"
#import "BAPreference.h"
#import "BAColorPicker.h"

@interface BAJauge ()
- (void)addDisplays;
@property(nonatomic, retain)UIView*		_fuller;
@property(nonatomic, retain)UIView*		_cursor;
@property(nonatomic, retain)UILabel*	_percent;
@end

@implementation BAJauge
@synthesize _fuller,
			_cursor,
			_percent;

#pragma mark public
#define BAJaugeHeight	33
#define BAJaugeLenght	243
#define BAJaugePos		10
- (void)fulling:(float)percent{
	float value			= percent/100 * BAJaugeLenght;
	float currentSize	= (value <= BAJaugeLenght)? value : BAJaugeLenght;
	
	if(percent > 100) percent = 100;
	
	_percent.text = [[NSNumber numberWithInt: percent] stringValue];
	[_fuller setFrame: CGRectMake(BAJaugePos, BAJaugePos, currentSize, BAJaugeHeight)];
	_cursor.center = CGPointMake(currentSize + 10, -5);
}

#define BAJaugeImage	@"jge.png"
#define BACursorImage	@"dar.png"
#pragma mark display
- (void)addDisplays{
	UIImageView* jaugeframe		= [[UIImageView alloc]	initWithImage: [UIImage imageNamed: BAJaugeImage]];
	UIView* background			= [[UIView alloc]		initWithFrame: CGRectMake(BAJaugePos, BAJaugePos, BAJaugeLenght, BAJaugeHeight)];
	[self set_percent:	[[UILabel alloc]		initWithFrame: CGRectMake(-5, -40, 100, 50)]];
	[self set_cursor:	[[UIImageView alloc]	initWithImage: [UIImage imageNamed: BACursorImage]]];
	[self set_fuller:	[[UIView alloc]			initWithFrame: CGRectMake(BAJaugePos, BAJaugePos, BAJaugeLenght, BAJaugeHeight)]];

	background.backgroundColor	= [UIColor redColor];
	_fuller.backgroundColor		= [UIColor whiteColor];

	_percent.backgroundColor	= [UIColor clearColor];
	_percent.font				= [UIFont fontWithName: BAFontKarime size: 40];
	_percent.textColor			= [BAColorPicker swatchColor: BAPurple];
	[_percent setNeedsDisplay];
	
	[_cursor	addSubview: _percent];
	[self		addSubview: background];
	[self		addSubview: _fuller];
	[self		addSubview: jaugeframe];
	[self		addSubview: _cursor];
	
	[background release];
	[jaugeframe release];
}

#pragma mark alloc/dealloc
- (id)init{
    if ((self = [super init])) {
		[self addDisplays];
    }
    return self;
}

- (void)dealloc{
	[_percent	release];
	[_cursor	release];
	[_fuller	release];
    [super		dealloc];
}
@end
