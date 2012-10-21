//
//  Phrases.h
//  iDecide
//
//  Created by Moshe Berman on 5/21/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "iDecideAppDelegate.h"

@interface Phrases : UITableViewController <UIAlertViewDelegate>{
	UIBarButtonItem * doneButton;
	NSArray *phrases;
}

 
@property (nonatomic, retain) UIBarButtonItem * doneButton;
@property (nonatomic, retain) NSArray *phrases;

- (void) removeEditor;

- (void) restorePhrases;

- (void) clearPhrases;

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex;

@end
