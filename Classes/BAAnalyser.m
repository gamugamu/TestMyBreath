//
//  BAAnalyser.m
//  BreathAnalyser
//
//  Created by loïc Abadie on 29/03/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "BAAnalyser.h"
#import "GGarchiver.h"
#import "GGswap.h"
@interface BAAnalyser()
- (BOOL)willThatSmellsGood;
- (NSArray*)coupoundPrecent;
@property(nonatomic, retain)NSString*		_smelling;
@property(nonatomic, retain)NSDictionary*	_data;
@end

@implementation BAAnalyser
@synthesize _smelling,
			_data;

#pragma mark public
- (NSDictionary*)makePieChart{
    NSMutableDictionary*    molecularList       = [NSMutableDictionary dictionaryWithDictionary:[[_data objectForKey:BAList_Molecular] objectForKey: _smelling]];
    NSArray*                molecularDatalist   = [self coupoundPrecent];
	uint					dataLength			= [molecularDatalist count];
    NSRange                 range               = {dataLength, [molecularList count] - dataLength};
    NSArray*                rangeKey            = [molecularList allKeys];

	rangeKey        = [GGSwap swapArray:rangeKey withStrengh:10];
    rangeKey        = [rangeKey subarrayWithRange: range];
    [molecularList removeObjectsForKeys: rangeKey];
	
	NSDictionary* transMolData = [NSDictionary dictionaryWithObjects:molecularDatalist forKeys: [molecularList allKeys]];
	
	return [NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects: transMolData, molecularList, nil]
									   forKeys:[NSArray arrayWithObjects: BAPercent, BAList_Molecular, nil]];
}

- (NSDictionary*)smellAnalysis{
	//srand (time(NULL));

	NSDictionary* data	= [[_data objectForKey: BAList_SmellSimilarity] objectForKey: _smelling];
	uint accessList		= rand() % [data count];
	NSString* key		= [[data allKeys] objectAtIndex: accessList];
	
    return [NSDictionary dictionaryWithObjects: [NSArray arrayWithObjects: key, [data objectForKey: key], nil]
									   forKeys: [NSArray arrayWithObjects: BASimLink, BASimComment, nil]];
}

- (NSString*)analysisComment{
	NSArray* data		= [[_data objectForKey: BAList_Result] objectForKey: _smelling];
	uint accessList		= rand() % ([data count] - 1);
    return [data objectAtIndex: accessList];
};

#pragma mark private
- (BOOL)willThatSmellsGood{
	BOOL smell = !(rand()%BARand);
    return smell;
}

#define cutRand     3
#define cutMax      60
#define cutPercent  100
#define cutin6      4
- (NSArray*)coupoundPrecent{
    srand (time(NULL));
    NSMutableArray* cutList     = [NSMutableArray arrayWithCapacity: cutin6];
    int stay                   = cutPercent;
    int i                       = 0;
    
    while (stay > 0){
        int cut		= (i >= cutin6)? stay : rand()%stay;
        if(!cut) cut = stay;
        cut			= (cut > cutMax)? cutMax : cut;
        stay		-= cut;
        [cutList addObject: [NSNumber numberWithUnsignedInt: cut]];
        i++;
    }
    return cutList;
}

#pragma mark alloc/dealloc
- (id)init{
    if((self = [super init])){
        [self set_smelling: ([self willThatSmellsGood])? BAGood : BABad];
		[self set_data: [GGarchiver unarchiveData:BAData]];
    }
    return self;
}

- (void)dealloc{
	[_data		release];
    [_smelling  release];
    [super      dealloc];
}
@end

