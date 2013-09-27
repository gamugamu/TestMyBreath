//
//  BATrans.h
//  BreathAnalyser
//
//  Created by loïc Abadie on 07/04/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol BATransDelegate
- (void)transFinished:(UIView*)view;
@end

@interface BATrans : NSObject
+(void)beginTransition:(UIView*)view withDelegate:(id<BATransDelegate>)delegate;
@end
