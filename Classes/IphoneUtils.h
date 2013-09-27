//
//  IphoneUtils.h
//  BreathAnalyser
//
//  Created by Abadie Loic on 27/09/13.
//
//

#import <Foundation/Foundation.h>

#define SCREEN_IPHONE_HEIGHT 568
#define IS_IPHONE_5 ( fabs( ( double )[ [ UIScreen mainScreen ] bounds ].size.height - ( double )SCREEN_IPHONE_HEIGHT ) < DBL_EPSILON )
#define SCREEN_IPHONE_5 CGRectMake(0, 0, 320, SCREEN_IPHONE_HEIGHT)