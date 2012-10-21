//
//  Phrases.h
//  iDecide
//
//  Created by Moshe Berman on 5/21/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "UFAppDelegate.h"

@interface UFPhrasesListViewController : UITableViewController <UIAlertViewDelegate>{
	UIBarButtonItem * doneButton;
	NSArray *phrases;
}

 
@property (nonatomic, strong) UIBarButtonItem * doneButton;
@property (nonatomic, strong) NSArray *phrases;

- (void) removeEditor;

- (void) restorePhrases;

- (void) clearPhrases;

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex;

@end
