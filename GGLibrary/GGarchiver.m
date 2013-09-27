//
//  GGarchiver.m
//  Lover's Day
//
//  Created by loïc Abadie on 14/12/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "GGarchiver.h"


@implementation GGarchiver
#pragma mark archive
+ (NSURL*)getTmpUrl{
	return [NSURL fileURLWithPath:NSTemporaryDirectory() ];
}

+ (NSString*)pathInNSDocumentDirectory:(NSString*)pathName{
	NSString *docsPath	= [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];	
	return 	[docsPath stringByAppendingPathComponent:pathName];
}

+ (void)archivingData:(id)Data withName:(NSString*)name{
	[NSKeyedArchiver	archiveRootObject: Data
								toFile: [GGarchiver pathInNSDocumentDirectory:name]];
}

+ (id)unarchiveData:(NSString*)path{
	id archive			= [NSKeyedUnarchiver unarchiveObjectWithFile:[GGarchiver pathInNSDocumentDirectory:path]];

	if(!archive){
		NSString* newPath	= [[NSBundle mainBundle] pathForResource:path ofType:@"plist"];
		archive				= [NSDictionary dictionaryWithContentsOfFile:newPath];
	}
	return archive;
}

@end
