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

#import "UFPhrasesListViewController.h"
#import "UFCreditsViewController.h"

@interface UFShakeViewController : UIViewController

@property (strong, nonatomic) UILabel *decisionText;

@property (nonatomic, strong) NSMutableArray* shakeReplies;
@property (nonatomic, strong) NSMutableArray* pokeReplies;

@property (nonatomic, strong) UIButton *bgImage;
@property (nonatomic, strong) UIButton *infoButton;
@property (nonatomic, strong) UIImageView *eyebrows;
@property (nonatomic,strong) UINavigationController *phrasesEditor;
@property (nonatomic, strong) UIButton *editorButton;
@property (nonatomic,strong) UFCreditsViewController *creditsView;
@property (strong, nonatomic) IBOutlet UIButton *tweetButton;

-(IBAction)buttonPressed:(id)sender;

-(IBAction)showCredits:(id)sender;

-(IBAction)showEditPhrases:(id)sender;

-(IBAction)toggleEyebrows:(id)sender;

-(void)genRandom:(BOOL)deviceWasShaken;

- (IBAction)sendTweet;

- (CAKeyframeAnimation *) attachPopUpAnimation;

@end


