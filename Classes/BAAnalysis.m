//
//  BAAnalysis.m
//  BreathAnalyser
//
//  Created by loïc Abadie on 29/03/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "BAAnalysis.h"
#import "BADetector.h"
#import "BAAnalyser.h"
#import "BAColorPicker.h"
#import "BAMolecularDataList.h"
#import "BAPreference.h"
#import "GGarchiver.h"
#import "GGTween.h"

@interface BAAnalysis()
- (void)decorate;
- (void)displayData;
@property(nonatomic, retain)BAAnalyser*				_analyser;
@property(nonatomic, retain)BAMolecularDataList*	_molecularList;
@property(nonatomic, retain)BAPieChartView*			_pieChartView;
@end

@implementation BAAnalysis
@synthesize _analyser,
			_molecularList,
			_pieChartView,
			_labelSimilarity,
			_labelResult;

#pragma mark Events
- (IBAction)buttonMakeAnalisysPressed:(id)sender{
	}

- (void)displayData{
	_labelResult.text		= [_analyser analysisComment];
	_labelSimilarity.text	= [[_analyser smellAnalysis] objectForKey: BASimComment];
	NSDictionary* data		= [_analyser makePieChart];
	NSDictionary* pieData	= [data objectForKey: BAPercent];
	
	[_pieChartView		removeFromSuperview];
	[_molecularList		removeFromSuperview];
	[self set_pieChartView: [[BAPieChartView alloc] initWithPieData: pieData 
													   andRayonSize: 75
														  intoFrame: CGRectMake(0, 55, 180, 330)]];
	
	[self set_molecularList: [[BAMolecularDataList alloc] initWithMolecularList: data
																	  intoFrame: CGRectMake(170, 140, 200, 230)]];
	[[self view] addSubview:_pieChartView];
	[[self view] addSubview:_molecularList];
}

enum{
	Label_BreathData = 50,
	Label_SmellSimilarity,
	Label_BreathResult
}BaAnalyse_Tag;

#pragma mark Decorate
- (void)decorate{
	UIView* view = [self view]; 
	NSDictionary* localisation		= [GGarchiver unarchiveData: BreathLocalisation];
	
	UIFont* Karim35					= [UIFont fontWithName: BAFontKarime size: 38];
	UIColor* greyDarkColor			= [BAColorPicker swatchColor: BADarkGray];
	UILabel* label_BreathData		= (UILabel*)[view viewWithTag: Label_BreathData];
	label_BreathData.text			= [localisation objectForKey: @"label_BreathData"];
	label_BreathData.font			= Karim35;
	label_BreathData.textColor		= greyDarkColor;

	UIFont* Karim20					= [UIFont fontWithName: BAFontKarime size: 18];
	UILabel* label_SmellSimilarity	= (UILabel*)[view viewWithTag: Label_SmellSimilarity];
	label_SmellSimilarity.text		= [localisation objectForKey: @"label_SmellSimilarity"];
	label_SmellSimilarity.textColor	= greyDarkColor;
	
	_labelSimilarity.font			=  [UIFont fontWithName: BAFontKarime size: 30];
	_labelSimilarity.textColor		= greyDarkColor;

	_labelResult.font				= Karim20;
	_labelResult.textColor			= [BAColorPicker swatchColor: BAGreenLight];
	_labelResult.numberOfLines		= 2;
	
	UIView* enclume					= [[self view] viewWithTag: 60];
	[GGTween tween: enclume.layer	to: (GGTweenVector){1, 1.05f} data: (GGTweenData){1, .6f, 0, 0, ggTweenScale, ggTweenBounce, MAXFLOAT, 0}];
}

#pragma mark delegate GGNavigator
- (BOOL)isFirst{
    return NO;
}

- (UIViewController*)next{
    return nil;
}

- (UIViewController*)previous{
    return [[[BADetector alloc] init] autorelease];
}

- (void)viewWillbeCalled:(GGNavigator*)navigator{
}

- (void)viewWillUndo{
}

#pragma mark alloc/dealloc
- (void)viewDidLoad{
    [self set_analyser:[[BAAnalyser alloc] init]];
	[self decorate];
    [self resizeIfIhpone5];
	[self displayData];
	[super	viewDidLoad];
}

- (void)viewDidUnload{
	_labelSimilarity	= nil;
	_labelResult		= nil;
	[super viewDidUnload];
}

- (void)dealloc{
	[_labelSimilarity	release];
	[_labelResult		release];
	[_molecularList		release];
	[_pieChartView		release];
	[_analyser			release];
    [super				dealloc];
}

#pragma mark - display

- (void)resizeIfIhpone5{
    if(IS_IPHONE_5){
        self.view.frame = SCREEN_IPHONE_5;
    }
}

@end