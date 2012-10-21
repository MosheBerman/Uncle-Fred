//
//  phraseDetail.m
//  iDecide
//
//  Created by Moshe Berman on 5/21/10.
//  Copyright 2010 Moshe Berman. All rights reserved.
//

#import "UFPhraseDetailEditorViewController.h"


@implementation UFPhraseDetailEditorViewController

@synthesize phraseBox, mode, phrase, phraseID, deleteButton;

/*
 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
        // Custom initialization
    }
    return self;
}
*/


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
		
	self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector(savePhrase:) ];
	
		phraseBox.keyboardAppearance = UIKeyboardAppearanceAlert;
    phraseBox.inputAccessoryView = deleteButton;
    [phraseBox becomeFirstResponder];
}

- (void) viewWillAppear:(BOOL)animated{
	if(self.phrase == nil){
		self.phrase = @"Type here...";
	}
	
	if([mode isEqualToString:@"edit"]){
		phraseBox.text = self.phrase;
		phraseBox.clearsOnBeginEditing = NO;
		if([[[NSUserDefaults standardUserDefaults] arrayForKey:@"customphrases"] count] > 1){
			deleteButton.hidden = NO;
		}else{
			deleteButton.hidden = YES;
		}
	}else{
		phraseBox.placeholder = @"Type here...";
		phraseBox.clearsOnBeginEditing = YES;
		deleteButton.hidden = YES;
	}
	
	[phraseBox setDelegate:self];
}
/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/


- (IBAction)savePhrase:(id)sender{
	
	//a temp array for adding purposes
	NSMutableArray *tempphrases = [[NSMutableArray alloc] initWithArray:[[NSUserDefaults standardUserDefaults] objectForKey:@"customphrases"]];
	
	//check against saving an empty phrase
	if(![phraseBox.text isEqualToString:@""]){
		
		//  if the textbox is not empty //
		
		if([mode isEqualToString:@"edit"]){
			
			// If we are editing //
			
			[tempphrases replaceObjectAtIndex:[phraseID unsignedIntegerValue] withObject:phraseBox.text];
			
			NSLog(@"%@", [phraseID stringValue]);
			
		}else if([mode isEqualToString:@"add"]){
			// otherwise (not "else", otherwise) we are adding //
			[tempphrases addObject:phraseBox.text];
		}

		
		//save the phrases 
		[[NSUserDefaults standardUserDefaults] setObject:tempphrases forKey:@"customphrases"];
		
		
		//return to the edit view
		[self.navigationController popToRootViewControllerAnimated:YES];	
	}else{
		
		//textbox is empty //
		
	 	UIAlertView *alrt = [[UIAlertView alloc] initWithTitle:@"" message:@"Please add a phrase." delegate:self cancelButtonTitle:@"Okay, I will." otherButtonTitles:nil];
		[alrt show];
	}
}

- (IBAction)cancelEdit:(id)sender{
	[sender endEditing:YES];
	phraseBox.clearsOnBeginEditing = NO;
	//[self.navigationController popToRootViewControllerAnimated:YES];
}


- (IBAction) deletePhrase:(id)sender{
	if([mode isEqualToString:@"edit"]){
		if([[[NSUserDefaults standardUserDefaults] objectForKey:@"customphrases"] count] > 1){
			UIAlertView *a = [[UIAlertView alloc] initWithTitle:@"Are you sure?"
														message:@"Are you sure that you want to delete this phrase? You can't undo this."
													   delegate:self
											  cancelButtonTitle:@"Nope"
											  otherButtonTitles:nil];
			[a addButtonWithTitle:@"Yes"];
			[a show];
		}else {
			UIAlertView *a = [[UIAlertView alloc] initWithTitle:@"You can't delete this"
														message:@"You can't delete this phrase, there are no more phrases."
													   delegate:nil
											  cancelButtonTitle:@"Okay"
											  otherButtonTitles:nil];
			[a show];
		}
	}
}


- (void) deletePhraseConfirmed{
	if([mode isEqualToString:@"edit"]){
		if([[[NSUserDefaults standardUserDefaults] objectForKey:@"customphrases"] count] > 1){
			
			NSMutableArray *tempphrases = [[NSMutableArray alloc] initWithArray:[[NSUserDefaults standardUserDefaults] objectForKey:@"customphrases"]];
			
			[tempphrases removeObjectAtIndex:[phraseID unsignedIntegerValue]];
			
			[[NSUserDefaults standardUserDefaults] setObject:tempphrases forKey:@"customphrases"];
			
			
			//return to the edit view
			[self.navigationController popToRootViewControllerAnimated:YES];
		}
		
	}	
}



- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex{
	if(buttonIndex == 1){
		[self deletePhraseConfirmed];
	}
}

#pragma mark -


- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
	
}




@end
