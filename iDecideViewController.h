//
//  iDecideViewController.h
//  iDecide
//
//  Created by Moshe Berman on 3/8/10.
//  Copyright __MyCompanyName__ 2010. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <QuartzCore/QuartzCore.h>
#import <AVFoundation/AVFoundation.h>

#import "Phrases.h"
#import "NavController.h"
#import "Credits.h"

@interface iDecideViewController : UIViewController {
	IBOutlet UILabel *decisionText;
	IBOutlet UIButton *bgImage; //the main button, the background
	IBOutlet UIButton *infoButton; //info button
	IBOutlet UIImageView *eyebrows; //eyebrows image
	IBOutlet UIButton *editorButton;
	NSMutableArray* shakeReplies;
	NSMutableArray* pokeReplies;
	
	NavController *phrasesEditor;
	
	Credits *creditsView;
}

@property (retain, nonatomic) UILabel *decisionText;

@property (nonatomic, retain) NSMutableArray* shakeReplies;
@property (nonatomic, retain) NSMutableArray* pokeReplies;

@property (nonatomic, retain) UIButton *bgImage;
@property (nonatomic, retain) UIButton *infoButton;
@property (nonatomic, retain) UIImageView *eyebrows;
@property (nonatomic,retain) NavController *phrasesEditor;
@property (nonatomic, retain) UIButton *editorButton;
@property (nonatomic,retain) Credits *creditsView;
@property (retain, nonatomic) IBOutlet UIButton *tweetButton;

-(IBAction)buttonPressed:(id)sender;

-(IBAction)showCredits:(id)sender;

-(IBAction)showEditPhrases:(id)sender;

-(IBAction)toggleEyebrows:(id)sender;

-(void)genRandom:(BOOL)deviceWasShaken;

- (IBAction)sendTweet;

- (CAKeyframeAnimation *) attachPopUpAnimation;

@end


