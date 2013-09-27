//
//  GGDevice.m
//  BreathAnalyser
//
//  Created by loïc Abadie on 17/02/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "GGDevice.h"
#import <sys/utsname.h>

@implementation GGDevice

+ (modelDevice)deviceModel{
	return nil;
	/*
    struct utsname systemInfo;
    uname(&systemInfo);
	NSString* const deviceName = [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];
	modelDevice md = 0;
	
	for (int i = 0; i < sizeof(modelName)/sizeof(NSString); i++)
		if([deviceName isEqualToString:modelName[i]])
			md = i;

	return md;*/
}
@end
