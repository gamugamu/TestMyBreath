//
//  Navigator.h
//  BreathAnalyser
//
//  Created by loïc Abadie on 28/03/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GGNavigatorDelegate.h"

@interface GGNavigator : UIViewController
- (id)initWithDelegate:(UIViewController*) delegate_;
- (void)goNextPressed;
- (IBAction)returnPressed:(id)sender;
@property(nonatomic, retain)IBOutlet UIView* _backButton;
@end
