//
//  BreathAnalyserViewController.m
//  BreathAnalyser
//
//  Created by loïc Abadie on 10/02/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "BADetector.h"
#import "BAEngine.h"
#import "BAStarter.h"
#import "BAAnalysis.h"
#import "BAColorPicker.h"
#import "BAJaugeController.h"
#import "BAPreference.h"
#import "BAAllover.h"
#import "GGNavigator.h"
#import "GGarchiver.h"
//#import "GGDevice.h"
#import "GGTween.h"

@interface BADetector()<BAEngineDelegate, BAJaugeDelegate>
- (void)showEngineIsWorkinView:(BOOL)isWorkin;
- (void)animateDetectorView;
- (void)animateNoDetectorView;
- (void)stopAnimating:(UIView*)view;
- (void)swapToDetector;
- (void)swapToNoDetector;
- (void)setUpTimer;
@property(nonatomic, assign)GGNavigator*			navigator;
@property(nonatomic, retain)BAEngine*				_engine;
@property(nonatomic, retain)BAJaugeController*		_jaugeC;
@property(nonatomic, retain)NSTimer*				_cancelTimer;
@property(nonatomic, retain)NSDate*					_lastTimeBlowed;
@property(nonatomic, retain)BAAllover*				_skullLayer;
@property(nonatomic, assign)BOOL					isBlowing;
@end

@implementation BADetector
@synthesize navigator,
			isBlowing,
            _engine,
			_detectedView,
			_noDetectedView,
			_currentStrenght,
			_jaugeC,
			_lastTimeBlowed,
			_cancelTimer,
			_skullLayer;

#pragma mark event
- (IBAction)launchBreathAnalyser:(id)sender{
	BOOL highlighted = [sender isSelected];
	[_jaugeC reset];
	[(UIButton*)sender setSelected: !highlighted];
	(!highlighted)? [_engine startAnalysingBreath] : [_engine stopAnalysingBreath];
	[self showEngineIsWorkinView: _engine.isDetecting];
}

- (void)showEngineIsWorkinView:(BOOL)isWorkin{
	[_detectedView setBackgroundColor: (isWorkin)?[UIColor greenColor] : [UIColor grayColor]];
	if(isWorkin)
		[self swapToDetector];
	else
		[self swapToNoDetector];
}

#pragma mark swap views
- (void)swapToDetector{
	[_noDetectedView removeFromSuperview];
	[self stopAnimating:		_noDetectedView];
	[[self view] addSubview:	_detectedView];
	[self animateDetectorView];
}

- (void)swapToNoDetector{
	[_detectedView removeFromSuperview];
	[self stopAnimating:		_detectedView];
	[[self view] addSubview:	_noDetectedView];
	[self animateNoDetectorView];
}

- (IBAction)swapNext:(id)sender{
    [navigator goNextPressed];
}

#pragma mark display
enum{
	MicInfo = 50,
	Label_A,
	Label_B,
	Label_AB,
	Label_ABTitle
}detected_tag;

enum{
	Label_Sorry = 50,
	Label_NoMicDetected,
	Label_WhatUcanDo
}noDetected_tag;

- (void)decorate{
	NSDictionary* localisation = 	[GGarchiver unarchiveData: BreathLocalisation];
	
	//-- detector view --//
	UILabel* infoBtn		= [[UILabel alloc] initWithFrame: CGRectMake(200, 170, 80, 60)];
	infoBtn.text			= [localisation objectForKey: @"MicInstruction"];
	UIFont* Karim16			= [UIFont fontWithName: BAFontKarime size: 16];
	infoBtn.font			= Karim16;
	infoBtn.textAlignment	= UITextAlignmentCenter;
	infoBtn.textColor		= [UIColor whiteColor];
	infoBtn.backgroundColor = [UIColor clearColor];
	infoBtn.numberOfLines	= 3;
	infoBtn.transform		= CGAffineTransformMakeRotation(-.16f);
	
	UILabel* micInfo		= (UILabel*)[_detectedView viewWithTag: MicInfo];
	micInfo.text			= [localisation objectForKey: @"MicDetected"];
	
	UIColor* pinkColor		= [BAColorPicker swatchColor: BAPurple];
	UIFont* Karim14			= [UIFont fontWithName: BAFontKarime size: 12];
	UILabel* label_A		= (UILabel*)[_detectedView viewWithTag: Label_A];
	label_A.text			= [localisation objectForKey: @"label_A"];
	label_A.font			= Karim14;
	label_A.textColor		= pinkColor;

	UILabel* label_B		= (UILabel*)[_detectedView viewWithTag: Label_B];
	label_B.text			= [localisation objectForKey: @"label_B"];
	label_B.font			= Karim14;
	label_B.textColor		= pinkColor;

	UIFont* Karim20			= [UIFont fontWithName: BAFontKarime size: 20];
	UILabel* label_ABTitle	= (UILabel*)[_detectedView viewWithTag: Label_ABTitle];
	label_ABTitle.text		= [localisation objectForKey: @"label_ABTitle"];
	label_ABTitle.font		= Karim20;
	label_ABTitle.textColor	= pinkColor;
	
	UILabel* label_AB		= (UILabel*)[_detectedView viewWithTag: Label_AB];
	label_AB.text			= [localisation objectForKey: @"label_AB"];
	label_AB.font			= Karim14;
	label_AB.textColor		= pinkColor;
	label_AB.numberOfLines	= 2;
	
	[_detectedView addSubview: infoBtn];
    UIView* backgroundGradient  = [_detectedView viewWithTag: 1];
    backgroundGradient.frame    = SCREEN_IPHONE_5;
	[backgroundGradient setBackgroundColor: [BAColorPicker swatchColor: BALightCyan]];
	[infoBtn release];
		
	//-- no detector view --//
	UIFont* Karim30			= [UIFont fontWithName: BAFontKarime size: 35];
	UILabel* label_Sorry	= (UILabel*)[_noDetectedView viewWithTag: Label_Sorry];
	label_Sorry.text		= [localisation objectForKey: @"label_Sorry"];
	label_Sorry.font		= Karim30;
	label_Sorry.textColor	= pinkColor;
	
	UILabel* label_NoMicDetected	= (UILabel*)[_noDetectedView viewWithTag: Label_NoMicDetected];
	label_NoMicDetected.text		= [localisation objectForKey: @"label_NoMicDetected"];
	label_NoMicDetected.textColor	= pinkColor;
	
	UILabel* label_WhatUCanDo		= (UILabel*)[_noDetectedView viewWithTag: Label_WhatUcanDo];
	label_WhatUCanDo.text			= [localisation objectForKey: @"label_WhatUCanDo"];
	label_WhatUCanDo.textColor		= pinkColor;
	[label_Sorry.layer removeAllAnimations];
	
	[[_noDetectedView viewWithTag: 1] setBackgroundColor: [BAColorPicker swatchColor: BAIvory]];
}

#pragma mark animations
#pragma mark animate
enum{
	Left_arrow = 70,
	Right_arrow
}no_detected_tag;

static BOOL inTrans = NO;
- (void)animateGauge{
	if(!inTrans){
		UIView* jauge		= [_jaugeC display];
		jauge.center		= CGPointMake(30, IS_IPHONE_5? 200 : 150);
		jauge.alpha			= 0;
		_skullLayer.alpha	= 1;
		[[self view] addSubview: _skullLayer];
		[[self view] addSubview: jauge];
		[UIView animateWithDuration: 1 animations:^(void) {
			_detectedView.alpha	= 0;
			jauge.alpha			= 1;
			_skullLayer.alpha	= 1;
		} completion:^(BOOL finished) {
			[_detectedView removeFromSuperview];
		}];
	
		isBlowing		= YES;
	}
}

- (void)animateUndoGauge{
	inTrans			= YES;
	UIView* jauge	= [[[self view] subviews] objectAtIndex: 0];
	[[self view] addSubview: _detectedView];
	
	[UIView animateWithDuration: 1 animations:^(void) {
		_detectedView.alpha	= 1;
		jauge.alpha			= 0;
		_skullLayer.alpha	= 0;
	} completion:^(BOOL finished) {
		[jauge			removeFromSuperview];
		[_skullLayer	removeFromSuperview];
		[_jaugeC reset];
		inTrans		= NO;
		isBlowing	= NO;
	}];
}

- (void)makeUndoGaugeIfNeeded{
	if([_lastTimeBlowed timeIntervalSinceNow] < -5){
		[self animateUndoGauge];
		[_cancelTimer invalidate];
	}
}

enum{
	MicContainer = 20,
	Bubble
}detectorAnm_tag;

- (void)animateDetectorView{
	UIView* micContainer	= [_detectedView viewWithTag: MicContainer];
	UIView* bubble			= [_detectedView viewWithTag: Bubble];
	[GGTween tween: micContainer.layer	to: (GGTweenVector){1, 1.05f} data: (GGTweenData){1, .6f, 0, 0, ggTweenScale, ggTweenBounce, MAXFLOAT, 0}];
	[GGTween tween: bubble.layer		to: (GGTweenVector){1, 1.05f} data: (GGTweenData){1, .4f, 0, 0, ggTweenScale, ggTweenLinear, MAXFLOAT, 0, 1}];	
}

- (void)animateNoDetectorView{
	UILabel* label_Sorry	= (UILabel*)[_noDetectedView viewWithTag: Label_Sorry];
	UIView* left_arrow		= (UILabel*)[_noDetectedView viewWithTag: Left_arrow];
	UIView* right_arrow		= (UILabel*)[_noDetectedView viewWithTag: Right_arrow];

	[GGTween tween: label_Sorry.layer	to: (GGTweenVector){1, 1.05f} data: (GGTweenData){1, .6f, 0, 0, ggTweenScale, ggTweenBounce, MAXFLOAT, 0}];
	[GGTween tween: left_arrow.layer	to: (GGTweenVector){235, 329} data: (GGTweenData){1, .4f, 0, 0, ggTweenPosition, ggTweenLinear, MAXFLOAT, 0, 1}];
	[GGTween tween: right_arrow.layer	to: (GGTweenVector){295, 338} data: (GGTweenData){1, .4f, 0, 0, ggTweenPosition, ggTweenLinear, MAXFLOAT, 0, 1}];
}

- (void)stopAnimating:(UIView*)view{	
	for (UIView* subview in [view subviews]){
		[subview.layer removeAllAnimations];
			for (UIView* subsubview in [subview subviews]){
				[self stopAnimating: subsubview];
		}
	}
}

#pragma mark BAEngineDelegate
- (void)blowOccuring:(float)strengh{
	[self set_lastTimeBlowed: [NSDate date]];
	
	if(isBlowing){
		[_currentStrenght setText: [[NSNumber numberWithFloat: strengh] stringValue]];
		[_jaugeC blowpulse: strengh];
	}else{
		[self setUpTimer];
		[self animateGauge];
	}
}

- (void)InBlowDetectionChanged:(BOOL)isDetecting{
	[self showEngineIsWorkinView: isDetecting];
}

#pragma mark GGNavigationDelegate
- (BOOL)isFirst{
	return NO;
}

- (UIViewController*)next{
	return [[[BAAnalysis alloc] init] autorelease];
};

- (UIViewController*)previous{
	return [[[BAStarter alloc] init] autorelease];
}

- (void)viewWillbeCalled:(GGNavigator*)navigator_{
	navigator = navigator_;
}

- (void)viewWillUndo{
    [_engine stopAnalysingBreath];
}

#pragma mark jaugeDelegate
- (void)jaugeIsFull{
	[_engine	stopAnalysingBreath];
	[navigator goNextPressed];
}

- (void)setUpTimer{
	[self set_cancelTimer: [NSTimer scheduledTimerWithTimeInterval: 2
															target: self
														  selector: @selector(makeUndoGaugeIfNeeded)
														  userInfo: nil 
														   repeats: YES]];
}

#pragma mark alloc/Dealloc
- (void)viewDidLoad {
	_engine		= [[BAEngine alloc] initWithDelegate: self];
	_jaugeC		= [[BAJaugeController alloc] initWithDelegate: self];
	_skullLayer	= [[BAAllover alloc] initWithFrame:CGRectMake(0, 0, 320, IS_IPHONE_5? SCREEN_IPHONE_HEIGHT : 480)];
	[_engine startAnalysingBreath];
    [self resizeIfIphone5];
	[self	decorate];
	[self	showEngineIsWorkinView: _engine.isDetecting];
    [super	viewDidLoad];
    [self swapToNoDetector];
}

- (void)didReceiveMemoryWarning {
	[_engine	stopAnalysingBreath];
    [super		didReceiveMemoryWarning];
}

- (void)viewDidUnload {
	[_engine	stopAnalysingBreath];
	[super		viewDidUnload];
}


- (void)dealloc {
	[_skullLayer			release];
	[_lastTimeBlowed		release];
	[_cancelTimer			release];
	[_jaugeC				release];
	[_detectedView			release];
	[_noDetectedView		release];
	[_engine				release];
    [super					dealloc];
}

#pragma mark - display

- (void)resizeIfIphone5{
    if(IS_IPHONE_5){
        self.view.frame = SCREEN_IPHONE_5;
        _noDetectedView.frame = SCREEN_IPHONE_5;
    }
}
@end
