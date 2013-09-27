//
//  BAAnalysis.h
//  BreathAnalyser
//
//  Created by loïc Abadie on 29/03/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GGNavigatorDelegate.h"
#import "BAPieChartView.h"

@interface BAAnalysis : UIViewController<GGNavigatorDelegate>
- (IBAction)buttonMakeAnalisysPressed:(id)sender;
@property(nonatomic, retain)IBOutlet UILabel* _labelSimilarity;
@property(nonatomic, retain)IBOutlet UILabel* _labelResult;
@end
