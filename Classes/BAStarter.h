//
//  BAStarter.h
//  BreathAnalyser
//
//  Created by loïc Abadie on 28/03/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GGNavigatorDelegate.h"
#import "BAStarterView.h"

@interface BAStarter:UIViewController<GGNavigatorDelegate>
@property(nonatomic, retain)IBOutlet BAStarterView* _mainView;
- (IBAction) startPressed:(id)sender;
- (IBAction) wimPressed:(id)sender;
@end
