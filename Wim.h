//
//  Wim.h
//  Lover's Day
//
//  Created by loïc Abadie on 26/01/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol WimDelegate <NSObject>
- (void)backPressed:(UIViewController*)wimController;
@end

@interface Wim : UIViewController
- (id)initWithDelegate:(id<WimDelegate>)delegate_;
- (void)animate:(UIView*)mainView;
- (IBAction)infoBackPresed:(id)sender;
@end
