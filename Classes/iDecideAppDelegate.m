//
//  iDecideAppDelegate.m
//  iDecide
//
//  Created by Moshe Berman on 3/8/10.
//  Copyright __MyCompanyName__ 2010. All rights reserved.
//

#import "iDecideAppDelegate.h"
#import "iDecideViewController.h"
@implementation iDecideAppDelegate

@synthesize window;
@synthesize viewController;


- (void)applicationDidFinishLaunching:(UIApplication *)application {    
    
    // Override point for customization after app launch    
    [window addSubview:viewController.view];
    [window makeKeyAndVisible];
	
}


- (void)dealloc {
    [viewController release];
    [window release];
    [super dealloc];
}


@end
