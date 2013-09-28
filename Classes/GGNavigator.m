//
//  Navigator.m
//  BreathAnalyser
//
//  Created by loïc Abadie on 28/03/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "GGNavigator.h"
#import "BATrans.h"

@interface GGNavigator()<BATransDelegate>
- (void)swapDelegate:(UIViewController*)delegate_;
@property(nonatomic, retain)UIViewController* _delegate;
@property(nonatomic, retain)UIViewController* _next_delegate;
@end

@implementation GGNavigator
@synthesize _backButton,
			_delegate,
			_next_delegate;

-(IBAction)returnPressed:(id)sender{
	[self swapDelegate: [(id <GGNavigatorDelegate>)_delegate previous]];
}

-(void)goNextPressed{
	[self swapDelegate: [(id <GGNavigatorDelegate>)_delegate next]];
}

- (void)viewDidLoad{
	[_backButton setHidden: YES];
    [self resizeIfIphone5];
    [super viewDidLoad];
}

- (void)transFinished:(UIView*)view{	
	[(id <GGNavigatorDelegate>)_delegate		viewWillUndo];
	[[_delegate view]							removeFromSuperview];
	
	[(id <GGNavigatorDelegate>)_next_delegate	viewWillbeCalled:self];
	[[self view]								insertSubview:[_next_delegate view] atIndex:0];
	
	([(id <GGNavigatorDelegate>)_next_delegate isFirst])? [_backButton setHidden:YES] : [_backButton setHidden:NO];
	
	[self set_delegate: _next_delegate];
	
	[UIView animateWithDuration:1 animations:^(void) {
		view.alpha = 0;
	} completion:^(BOOL finished) {
		[view removeFromSuperview];
	}];
}

- (void)swapDelegate:(UIViewController*)delegate_{
	[self set_next_delegate: delegate_];
	[BATrans beginTransition:[self view] withDelegate: self];
}

- (id)initWithDelegate:(UIViewController*) delegate_{
	if((self = [super init])){
		[self set_delegate: delegate_];
		[[self view] insertSubview:[delegate_ view] atIndex:0];
		[(id <GGNavigatorDelegate>)delegate_ viewWillbeCalled: self];
	}
	return self;
}

- (void)dealloc{
	[_next_delegate	release];
	[_delegate		release];
	[_backButton	release];
    [super			dealloc];
}

#pragma mark - display

- (void)resizeIfIphone5{
    if(IS_IPHONE_5){
        self.view.frame = SCREEN_IPHONE_5;
    }
}
@end
