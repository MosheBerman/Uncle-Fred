//
//  iDecideViewController.h
//  iDecide
//
//  Created by Moshe Berman on 3/8/10.
//  Copyright __MyCompanyName__ 2010. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <AudioToolbox/AudioToolbox.h>

@interface iDecideViewController : UIViewController{
	IBOutlet UILabel *decisionText;
	IBOutlet UIButton *bgImage; //the main button, the background
	IBOutlet UIButton *infoButton; //info button
	IBOutlet UIImageView *eyebrows; //eyebrows image
	NSMutableArray* shakeReplies;
	NSMutableArray* pokeReplies;
	
}

@property (retain, nonatomic) UILabel *decisionText;

@property (nonatomic, retain) NSMutableArray* shakeReplies;

@property (nonatomic, retain) NSMutableArray* pokeReplies;

@property (nonatomic, retain) UIButton *bgImage;

@property (nonatomic, retain) UIButton *infoButton;

@property (nonatomic, retain) UIImageView *eyebrows;


-(IBAction)buttonPressed:(id)sender;

-(IBAction)showCredits:(id)sender;

-(IBAction)toggleEyebrows:(id)sender;

-(void)genRandom:(BOOL)deviceWasShaken;

@end


