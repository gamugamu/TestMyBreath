//
//  BAPieLayer.h
//  BreathAnalyser
//
//  Created by loïc Abadie on 30/03/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <QuartzCore/QuartzCore.h>

@interface BAPieLayer : CALayer
- (id)initWithPercent:(CGPoint)degPercent_ andColors:(UIColor*)color;
@property(nonatomic, assign)CGPoint		degPercent;
@property(nonatomic, retain)UIColor*	_color;
@property(nonatomic, assign)float		rSize;
@end
