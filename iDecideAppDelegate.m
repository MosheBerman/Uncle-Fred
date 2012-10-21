//
//  iDecideAppDelegate.m
//  iDecide
//
//  Created by Moshe Berman on 3/8/10.
//  Copyright __MyCompanyName__ 2010. All rights reserved.
//

#import "iDecideAppDelegate.h"
#import "iDecideViewController.h"
#import "Phrases.h"
#import "phraseDetail.h"
#import "NavController.h"

@implementation iDecideAppDelegate

@synthesize window;
@synthesize viewController;
@synthesize customphrases;

- (void)applicationDidFinishLaunching:(UIApplication *)application {    
    
# pragma mark -
	
#pragma mark First Run Setup
	if([PREFS boolForKey:@"previouslyrun"] != YES){
	//if(1){
		/*first Run */
		
		/* set the custom phrases */

		[PREFS setBool:YES forKey:@"sound_preference"];
		
		[PREFS setBool:YES forKey:@"eyebrows_preference"];
		[PREFS setBool:YES forKey:@"custom_preference"];
		
		NSArray *tempreplies = [[NSMutableArray alloc] initWithContentsOfFile:[[NSBundle mainBundle]pathForResource:@"ShakenList" ofType:@"plist"]];
		[PREFS setObject:tempreplies forKey:@"customphrases"];
		[tempreplies release];
		
		
		//Welcome message//
		/*
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"You're about to experience Uncle Fred!" message:@"Uncle Fred is a fun task management application. \n To see a joke or a task, shake your device. \n\nTap on the pen to add your own jokes, or you can clear the default jokes and use Uncle Fred to manage your tasks." delegate:nil cancelButtonTitle:@"Great, I'm pumped!" otherButtonTitles:nil];
		[alert show];
		[alert release];
		*/
		
		// Remember that we have gone through first run before //
		[PREFS setBool:YES forKey:@"previouslyrun"];
	}
	
    // Override point for customization after app launch    
    [window addSubview:viewController.view];
    [window makeKeyAndVisible];
}


- (void)dealloc {
	[customphrases release];
    [viewController release];
    [window release];
    [super dealloc];
}


@end
