//
//  iDecideAppDelegate.h
//  iDecide
//
//  Created by Moshe Berman on 3/8/10.
//  Copyright __MyCompanyName__ 2010. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

@class iDecideViewController;

@interface iDecideAppDelegate : NSObject <UIApplicationDelegate>

@property (nonatomic, strong) IBOutlet UIWindow *window;
@property (nonatomic, strong) IBOutlet iDecideViewController *viewController;
@property (nonatomic, strong) NSArray *customphrases;

@end

