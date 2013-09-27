//
//  GGNavigatorDelegate.h
//  BreathAnalyser
//
//  Created by loïc Abadie on 28/03/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class GGNavigator;
@protocol GGNavigatorDelegate
- (BOOL)isFirst;
- (UIViewController*)next;
- (UIViewController*)previous;
- (void)viewWillbeCalled:(GGNavigator*)navigator;
- (void)viewWillUndo;
@end
