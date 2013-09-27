//
//  BreathAnalyserAppDelegate.m
//  BreathAnalyser
//
//  Created by loïc Abadie on 10/02/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "BAAppDelegate.h"
#import "GGNavigator.h"
#import "BAStarter.h"

@implementation BAAppDelegate
@synthesize window,
			viewController;


#pragma mark -
#pragma mark Application lifecycle
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions{
	BAStarter* starter = [[BAStarter alloc] init];
 	NSLog(@"---> %@", viewController.view);
    
	GGNavigator* ggNavigator	= [[GGNavigator alloc] initWithDelegate: starter];
	[self           setViewController: ggNavigator];
    [self.window    addSubview: viewController.view];
    [self.window    makeKeyAndVisible];
	[ggNavigator	release];
    return YES;
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    /*
     Called as part of  transition from the background to the inactive state: here you can undo many of the changes made on entering the background.
     */
}

#pragma mark -
#pragma mark Memory management

- (void)dealloc {
    [viewController release];
    [window release];
    [super dealloc];
}


@end
