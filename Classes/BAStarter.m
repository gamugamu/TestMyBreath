//
//  BAStarter.m
//  BreathAnalyser
//
//  Created by loïc Abadie on 28/03/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "BAStarter.h"
#import "BADetector.h"
#import "GGNavigator.h"
#import "Wim.h"

@interface BAStarter()<WimDelegate>
@property(nonatomic, assign)GGNavigator* navigator;
@property(nonatomic, assign)Wim* wim;
@end

@implementation BAStarter
@synthesize _mainView,
			wim,
			navigator;

#pragma mark button logic
- (IBAction) startPressed:(id)sender{
    
	[navigator goNextPressed];
}

- (IBAction) wimPressed:(id)sender{
	wim = [[Wim alloc] initWithDelegate: self];
	[wim animate: [self view]];
}

- (void)backPressed:(UIViewController*)wimController{
	[wim release];
}

#pragma mark GGNavigationDelegate
- (BOOL)isFirst{
	return YES;
}

- (UIViewController*)next{
	return [[[BADetector alloc] init] autorelease];
};

- (UIViewController*)previous{
	return nil;
}


- (void)viewWillbeCalled:(GGNavigator*)navigator_{
	navigator = navigator_;
}

- (void)viewWillUndo{
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
	[_mainView	release];
    [super		dealloc];
}


@end
