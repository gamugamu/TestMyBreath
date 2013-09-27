//
//  BAColorPicker.m
//  BreathAnalyser
//
//  Created by loïc Abadie on 30/03/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "BAColorPicker.h"


@implementation BAColorPicker
+ (UIColor*)swatchColor:(BAColors)color{
    UIColor* currentColor;
    switch (color) {
		case BAYellow:		currentColor = [UIColor colorWithRed:1		green:1		blue:0		alpha:1];   break;
        case BAPink:		currentColor = [UIColor colorWithRed:1		green:.3f	blue:.76f	alpha:1];   break;
        case BAOrange:		currentColor = [UIColor colorWithRed:1		green:.18f	blue:0		alpha:1];   break;
		case BABrown:		currentColor = [UIColor colorWithRed:.63f	green:.18f	blue:.3f	alpha:1];   break;
        case BALightGrey:	currentColor = [UIColor colorWithRed:.34f	green:.34f	blue:.31f	alpha:1];   break;
        case BAPurple:		currentColor = [UIColor colorWithRed:.35f	green:.08f	blue:.31f	alpha:1];   break;
        case BADarkGray:	currentColor = [UIColor colorWithRed:.17f	green:.16f	blue:.1f	alpha:1];   break;
        case BABluePerl:	currentColor = [UIColor colorWithRed:.15f	green:.49f	blue:.56f	alpha:1];   break;
		case BALightCyan:	currentColor = [UIColor colorWithRed:.70f	green:1		blue:.80f	alpha:1];   break;
        case BAGreen:		currentColor = [UIColor colorWithRed:.49f	green:.71f	blue:0		alpha:1];   break;
        case BAGreenDark:	currentColor = [UIColor colorWithRed:.63f	green:.57f	blue:.01f	alpha:1];   break;
		case BAGreenLight:	currentColor = [UIColor colorWithRed:.85f	green:.71f	blue:0		alpha:1];   break;
        case BAIvory:		currentColor = [UIColor colorWithRed:1		green:1		blue:.79f	alpha:1];   break;
		case BAWhite:		currentColor = [UIColor colorWithRed:1		green:1		blue:1		alpha:1];   break;
		default:			currentColor = [UIColor colorWithRed:0		green:0		blue:0		alpha:1];   break;

    }
    return currentColor;
}

@end
