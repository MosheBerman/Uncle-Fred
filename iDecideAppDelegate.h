//
//  iDecideAppDelegate.h
//  iDecide
//
//  Created by Moshe Berman on 3/8/10.
//  Copyright __MyCompanyName__ 2010. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

#define PREFS [NSUserDefaults standardUserDefaults]

@class iDecideViewController;

@interface iDecideAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    iDecideViewController *viewController;
	NSArray *customphrases;
	
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet iDecideViewController *viewController;
@property (nonatomic, retain) NSArray *customphrases;

@end

