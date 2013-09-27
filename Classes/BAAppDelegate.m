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
    
	GGNavigator* ggNavigator	= [[[GGNavigator alloc] initWithDelegate: starter] autorelease];
	[self setViewController: ggNavigator];
    
    self.window.rootViewController = self.viewController;
    [self.window    addSubview: viewController.view];
    self.window.frame = CGRectMake(0, 0, 320, 568);

    [self.window    makeKeyAndVisible];
    return YES;
}

- (NSUInteger)application:(UIApplication *)application supportedInterfaceOrientationsForWindow:(UIWindow *)window{
    return UIInterfaceOrientationMaskPortrait;
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
