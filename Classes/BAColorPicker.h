//
//  BAColorPicker.h
//  BreathAnalyser
//
//  Created by loïc Abadie on 30/03/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum{
	BAYellow,
    BAPink,
    BAOrange,
	BABrown,
	BALightGrey,
	BAPurple,
	BADarkGray,
	BABluePerl,
	BALightCyan,
	BAGreen,
	BAGreenDark,
	BAGreenLight,
	BAIvory,
	BAWhite
}BAColors;

@interface BAColorPicker : NSObject
+ (UIColor*)swatchColor:(BAColors)color;
@end
