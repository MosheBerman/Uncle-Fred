//
//  iDecideAppDelegate.h
//  iDecide
//
//  Created by Moshe Berman on 3/8/10.
//  Copyright Moshe Berman 2010. All rights reserved.
//

#import <UIKit/UIKit.h>

@class UFShakeViewController;

@interface UFAppDelegate : NSObject <UIApplicationDelegate>

@property (nonatomic, strong) UIWindow *window;
@property (nonatomic, strong) UFShakeViewController *viewController;
@property (nonatomic, strong) NSArray *customphrases;

@end

