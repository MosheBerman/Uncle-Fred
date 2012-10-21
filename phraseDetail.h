//
//  phraseDetail.h
//  iDecide
//
//  Created by Moshe Berman on 5/21/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "UFAppDelegate.h"

@interface phraseDetail : UIViewController <UITextFieldDelegate>{
	IBOutlet UITextField *phraseBox;
	IBOutlet UIButton *deleteButton;
	NSString *mode;
	NSString *phrase;
	NSNumber *phraseID;

}

@property (nonatomic, strong) UITextField *phraseBox;

@property (nonatomic, strong) NSString *mode;

@property (nonatomic, strong) NSString *phrase;

@property (nonatomic, strong) NSNumber *phraseID;

@property (nonatomic, strong) UIButton *deleteButton;

- (IBAction)savePhrase:(id)sender;

- (IBAction)cancelEdit:(id)sender;

- (IBAction) deletePhrase:(id)sender;

- (void) deletePhraseConfirmed;

@end
