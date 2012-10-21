//
//  phraseDetail.h
//  iDecide
//
//  Created by Moshe Berman on 5/21/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "iDecideAppDelegate.h"

@interface phraseDetail : UIViewController <UITextFieldDelegate>{
	IBOutlet UITextField *phraseBox;
	IBOutlet UIButton *deleteButton;
	NSString *mode;
	NSString *phrase;
	NSNumber *phraseID;

}

@property (nonatomic, retain) UITextField *phraseBox;

@property (nonatomic, retain) NSString *mode;

@property (nonatomic, retain) NSString *phrase;

@property (nonatomic, retain) NSNumber *phraseID;

@property (nonatomic, retain) UIButton *deleteButton;

- (IBAction)savePhrase:(id)sender;

- (IBAction)cancelEdit:(id)sender;

- (IBAction) deletePhrase:(id)sender;

- (void) deletePhraseConfirmed;

@end
