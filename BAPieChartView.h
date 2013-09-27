//
//  BAPieChartView.h
//  BreathAnalyser
//
//  Created by loïc Abadie on 29/03/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BAPieChartView : UIView
- (id)initWithPieData:(NSDictionary*)percentData andRayonSize:(float)rSize_  intoFrame:(CGRect)frame;
@end
