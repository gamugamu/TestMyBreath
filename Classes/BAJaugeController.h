//
//  BAJaugeController.h
//  BreathAnalyser
//
//  Created by loïc Abadie on 01/04/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol BAJaugeDelegate
- (void)jaugeIsFull;
@end

@interface BAJaugeController : NSObject
- (id)initWithDelegate:(id<BAJaugeDelegate>)delegate_;
- (UIView*)display;
- (void)blowpulse:(float)pulse;
- (void)reset;
@property(nonatomic, assign)id<BAJaugeDelegate> delegate;
@end
