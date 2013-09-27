//
//  BreathAnalyserViewController.h
//  BreathAnalyser
//
//  Created by loïc Abadie on 10/02/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GGNavigatorDelegate.h"

@interface BADetector : UIViewController<GGNavigatorDelegate>
@property(nonatomic, retain)IBOutlet UIView*	_detectedView;
@property(nonatomic, retain)IBOutlet UIView*	_noDetectedView;
@property(nonatomic, retain)IBOutlet UILabel*	_currentStrenght;

- (IBAction)launchBreathAnalyser:(id)sender;
- (IBAction)swapNext:(id)sender;
@end

