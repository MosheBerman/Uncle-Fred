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

- (void)applicationDidFinishLaunching:(UIApplication *)application {    
    
	if([[NSUserDefaults standardUserDefaults] boolForKey:@"previouslyrun"] != YES){
	//if(1){
		/*first Run */
		
		/* set the custom phrases */

		[[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"sound_preference"];
		
		[[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"eyebrows_preference"];
		[[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"custom_preference"];
		
		NSArray *tempreplies = [[NSMutableArray alloc] initWithContentsOfFile:[[NSBundle mainBundle]pathForResource:@"ShakenList" ofType:@"plist"]];
		[[NSUserDefaults standardUserDefaults] setObject:tempreplies forKey:@"customphrases"];
		[tempreplies release];
		
		
		//Welcome message//
		/*
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"You're about to experience Uncle Fred!" message:@"Uncle Fred is a fun task management application. \n To see a joke or a task, shake your device. \n\nTap on the pen to add your own jokes, or you can clear the default jokes and use Uncle Fred to manage your tasks." delegate:nil cancelButtonTitle:@"Great, I'm pumped!" otherButtonTitles:nil];
		[alert show];
		[alert release];
		*/
		
		// Remember that we have gone through first run before //
		[[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"previouslyrun"];
	}
	
    // Override point for customization after app launch    
    [[self window] setRootViewController:[self viewController]];
    [[self window] makeKeyAndVisible];
}


- (void)dealloc {
	[_customphrases release];
    [_viewController release];
    [_window release];
    [super dealloc];
}


@end
