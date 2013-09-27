//
//  BAAnalyser.h
//  BreathAnalyser
//
//  Created by loïc Abadie on 29/03/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

#define BARand						6
#define BAData						@"BreathData"
#define BAGood						@"good"
#define BABad						@"bad"
#define BAPercent					@"percentage"
#define BAList_Molecular			@"List_Molecular"
#define BAList_SmellSimilarity		@"List_SmellSimilarity"
#define BAList_Result				@"List_Result"
#define BASimLink					@"BASimLink"
#define BASimComment				@"BASimComment"

@interface BAAnalyser : NSObject
- (NSDictionary*)makePieChart;
- (NSDictionary*)smellAnalysis;
- (NSString*)analysisComment;
@end
