//
//  GGDevice.h
//  BreathAnalyser
//
//  Created by loïc Abadie on 17/02/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum{
	DUnknow,
	DSimulator,
	DIpod1,
	DIpod2,
	DIpod3,
	DIpod4,
	DIPhone1G,
	DIPhone3G,
	DIPhone3GS,
	DIPhone4G,
	DIPad
}modelDevice;

@interface GGDevice : NSObject
+ (modelDevice)deviceModel;
@end
