//
//  iDecideViewController.m
//  iDecide
//
//  Created by Moshe Berman on 3/8/10.
//  Copyright Moshe Berman 2010. All rights reserved.
//

#import "iDecideViewController.h"

@implementation iDecideViewController

@synthesize decisionText, shakeReplies, pokeReplies, bgImage, infoButton, eyebrows;

/* Generate random label and apply it */
-(void)genRandom:(BOOL)deviceWasShaken{
	/* TODO: Address book and location Based responses */
	if(deviceWasShaken == TRUE){
		decisionText.text = [NSString stringWithFormat: (@"%@", [shakeReplies objectAtIndex:(arc4random() % [shakeReplies count])])];
	}else{
		SystemSoundID SoundID;
		NSString *soundFile = [[NSBundle mainBundle] pathForResource:@"string" ofType:@"aif"];
		AudioServicesCreateSystemSoundID((CFURLRef)[NSURL fileURLWithPath:soundFile], &SoundID);
		AudioServicesPlayAlertSound(SoundID);
		decisionText.text = [NSString stringWithFormat: (@"%@", [pokeReplies objectAtIndex:(arc4random() % [pokeReplies count])])];

	}
}

-(IBAction)buttonPressed:(id)sender{
	[self genRandom:FALSE];
}

-(IBAction)showCredits:(id)sender{
	UIAlertView *creds = [[UIAlertView alloc] initWithTitle:@"About Uncle Fred:" message: @"Uncle Fred was programmed by Moshe Berman on an old Intel MacBook which he borrowed from one of his uncles. (No, seriously!)\n \n \nYou can get support and more information about this app at: \n \n \nwww.YetAnotheriPhoneApp.com" delegate:self cancelButtonTitle:@"Okay, lets go!" otherButtonTitles:nil];
	[creds show];
	[creds release];
	
}

/* Change eyebrows */
-(IBAction)toggleEyebrows:(id)sender{
	NSArray *hairstyles = [[NSArray alloc] initWithObjects:@"black_hair", @"leaf_hair", @"gray_hair", @"purple_hair", @"purple_shiny", @"yellow_shiny", @"yellow_flower", @"pastel_hair", @"pastel_brown", @"carbon", @"promenade", @"promenade_2", @"polka", nil];
	
	NSString *hairTitle = [NSString stringWithFormat: (@"%@", [hairstyles objectAtIndex:(arc4random() % [hairstyles count])])];
	
	UIImage * hairStyle = [[UIImage alloc]initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:hairTitle ofType:@"png"]];
	[eyebrows setImage:hairStyle];
	[hairStyle release];
	[hairstyles release];
 }

/* Shaking began method */
- (void)motionBegan:(UIEventSubtype)motion withEvent:(UIEvent *)event {
	SystemSoundID SoundID;
	NSString *soundFile = [[NSBundle mainBundle] pathForResource:@"shake" ofType:@"aif"];
	AudioServicesCreateSystemSoundID((CFURLRef)[NSURL fileURLWithPath:soundFile], &SoundID);
	AudioServicesPlayAlertSound(SoundID);	
	[self genRandom:TRUE];
}

/* Shaking method */
- (void)motionStarted:(UIEventSubtype)motion withEvent:(UIEvent *)event {
	[self genRandom:TRUE];
}

-(BOOL)canBecomeFirstResponder {
    return YES;
}

-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self becomeFirstResponder];
}

- (void)viewWillDisappear:(BOOL)animated {
    [self resignFirstResponder];
    [super viewWillDisappear:animated];
}

/* Rotation Method */
- (void)orientationChanged:(NSNotification *)notif{
	/*  */
	
}

/*
// The designated initializer. Override to perform setup that is required before the view is loaded.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        // Custom initialization
    }
    return self;
}
*/

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
}
*/

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	decisionText.text = @"I'm your favorite uncle. Uncle Fred. (I'm very friendly.) To see what I'm thinking, shake your device.";
	pokeReplies = [[NSMutableArray alloc] initWithContentsOfFile:[[NSBundle mainBundle]pathForResource:@"PokedList" ofType:@"plist"]];
	shakeReplies = [[NSMutableArray alloc] initWithContentsOfFile:[[NSBundle mainBundle]pathForResource:@"ShakenList" ofType:@"plist"]];	
	
	/*
	 *
	 *
	 *
	   TODO: Use addObjectFromArray to add user-supplied replies via a settings bundle or a "customize" view
	[shakeReplies addObjectsFromArray:customReplies];

	END TODO 
	 
	 *
	 *
	 *
	 *
	 *
	 */
	
	[[UIDevice currentDevice] beginGeneratingDeviceOrientationNotifications];
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(orientationChanged:)
												 name:UIDeviceOrientationDidChangeNotification object:nil];
}




// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
	if(interfaceOrientation == UIDeviceOrientationPortrait || interfaceOrientation == UIDeviceOrientationPortraitUpsideDown){
		return YES;
		
	}else{
		return NO;	
	}
}


- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

-(void) viewWillUnload{
	[pokeReplies release];
	[shakeReplies release];
	[[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}


- (void)dealloc {
	
	[[UIDevice currentDevice] endGeneratingDeviceOrientationNotifications];
	[eyebrows release];
	[bgImage release];
	[infoButton release];
	[decisionText release];
	[pokeReplies release];
	[shakeReplies release];
    [super dealloc];
}

@end
