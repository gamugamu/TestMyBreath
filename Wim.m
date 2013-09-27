//
//  Wim.m
//  Lover's Day
//
//  Created by loïc Abadie on 26/01/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "Wim.h"
#import "GGTween.h"
#import "GGarchiver.h"

@interface Wim()
@property(nonatomic, assign)BOOL canExit;
@property(nonatomic, assign)id<WimDelegate> delegate;
@end

@implementation Wim
@synthesize canExit,
			delegate;

enum{
	wim_lb_info = 30,
};

#define WIM_PLIST	@"Wim"
#define WIM_INFO	@"Wm_info"
- (void)viewDidLoad {
	//((UILabel*)[self.view viewWithTag:wim_lb_info]).text = [[GGarchiver unarchiveData: WIM_PLIST] objectForKey:WIM_INFO];
    [super viewDidLoad];
}


#pragma mark button_logic
enum{
	LD_wimBkg_tag = 100,
	LD_wimBlk_tag,
};

- (void)animate:(UIView*)mainView{
	canExit				= YES;
	UIView* content		= self.view;
	CALayer* bkg			= [content viewWithTag: LD_wimBkg_tag].layer;
	CALayer* blk			= [content viewWithTag: LD_wimBlk_tag].layer;
	bkg.opacity			= 0;
	blk.opacity			= 0.01005;
	[mainView addSubview:content];
	[GGTween tween:bkg to:(GGTweenVector){0,.8}			data:(GGTweenData){1, .8, 0, 0, ggTweenOpacity, ggTweenLinear}];
	[GGTween tween:blk to:(GGTweenVector){0,1}			data:(GGTweenData){1, .7, .5, 0, ggTweenOpacity, ggTweenLinear}];
	[GGTween tween:blk to:(GGTweenVector){1.05, .95}	data:(GGTweenData){1, .7, .5, 1, ggTweenScale, ggTweenBounce}];
}

- (IBAction)infoBackPresed:(id)sender{
	if(!canExit)		return;
	canExit				= NO;
	UIView* content		= self.view;
	CALayer* bkg		= [content viewWithTag: LD_wimBkg_tag].layer;
	CALayer* blk		= [content viewWithTag: LD_wimBlk_tag].layer;
	[GGTween tween:bkg to:(GGTweenVector){.8,0}			data:(GGTweenData){1, .5, .5, 1, ggTweenOpacity, ggTweenLinear}];
	[GGTween tween:blk to:(GGTweenVector){1,0}			data:(GGTweenData){1, .8, 0, 2, ggTweenOpacity, ggTweenLinear}];
	[GGTween tween:blk to:(GGTweenVector){.95, 1.05}	data:(GGTweenData){1, .8, 0, 3, ggTweenScale, ggTweenBounce}];
	[self performSelector:@selector(removeWim) withObject:nil afterDelay:1];
}

- (void)removeWim{
	[self.view removeFromSuperview];
	[delegate backPressed: self];
}

- (id)initWithDelegate:(id<WimDelegate>)delegate_{
	if((self = [super init])){
		delegate = delegate_;
	}
	
	return self;
}
@end
