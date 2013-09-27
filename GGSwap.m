//
//  GGSwap.m
//  BreathAnalyser
//
//  Created by loïc Abadie on 29/03/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "GGSwap.h"


@implementation GGSwap
+ (NSArray*)swapArray:(NSArray*)array withStrengh:(uint)strenght{
	if(![array count]) 
		return array;
	
    srand (time(NULL));
    uint lenght = [array count];
    NSMutableArray* temp = [NSMutableArray arrayWithArray: array];
    
    for (int i = 0; i <= strenght; i++)
        [temp exchangeObjectAtIndex:rand()%lenght withObjectAtIndex:rand()%lenght];
    
		return temp;
}
@end
