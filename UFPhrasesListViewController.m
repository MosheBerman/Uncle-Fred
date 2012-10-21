//
//  Phrases.m
//  iDecide
//
//  Created by Moshe Berman on 5/21/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "UFPhrasesListViewController.h"
#import "phraseDetail.h"

@implementation UFPhrasesListViewController

@synthesize doneButton;
@synthesize phrases;

#pragma mark -
#pragma mark View lifecycle


- (void)viewDidLoad {
    [super viewDidLoad];
	
	//Add the done button to the Nav Bar
	self.navigationItem.leftBarButtonItem = [ [UIBarButtonItem alloc]
											   initWithTitle:@"Done" 
											   style: UIBarButtonItemStyleBordered
											   target:self
											   action:@selector(removeEditor)];
 
	self.navigationItem.rightBarButtonItem = [ [UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(showAddView)];

	[self.navigationController.navigationBar setTranslucent:YES];
	[self.navigationController.navigationBar setTintColor:[UIColor brownColor ]];
	
	[self setTitle:@"UFPhrasesListViewController"];
	
	[self.tableView setBackgroundView:[[UIImageView alloc] initWithImage:[[UIImage alloc] initWithContentsOfFile:[[NSBundle mainBundle]pathForResource:@"phrases" ofType:@"png"]]]];
	
	//store a copy of the phrases array
	self.phrases = [[NSArray alloc] initWithArray:[[NSUserDefaults standardUserDefaults] objectForKey:@"customphrases"]];
}

#pragma mark -
#pragma mark Editor button controls
-(void)removeEditor{

	
	[self.navigationController dismissModalViewControllerAnimated:YES];
	
}

-(void)showAddView{
	phraseDetail *detailViewController = [[phraseDetail alloc] initWithNibName:@"phraseDetail" bundle:nil];
	
	// Pass the selected object to the new view controller.
	detailViewController.mode = @"add";
	detailViewController.title = @"Add A Phrase";
	detailViewController.phrase = @"Type here...";
	[self.navigationController pushViewController:detailViewController animated:YES];

}



- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
		self.phrases = [[NSArray alloc] initWithArray:[[NSUserDefaults standardUserDefaults] objectForKey:@"customphrases"]];
		[self.tableView reloadData];

}

/*
- (void)viewWillDisappear:(BOOL)animateWillDisappear:animated];
}
 {
	*/
/*
- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
}
*/
/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/


#pragma mark -
#pragma mark Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

	if(section == 0){
		return [phrases count]; 
	}else{
		return 2;	
	}
}


// TODO: Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
		
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    // TODO: Configure the cell...
    
	
	if([indexPath section] == 0){
		cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
		[cell.textLabel setText:[phrases objectAtIndex:[indexPath row]]];
	}else{
		if ([indexPath row] == 0) {
			cell.accessoryType = UITableViewCellAccessoryNone;
			[cell.textLabel setText:@"Reset Jokes"];
			[cell.textLabel setTextAlignment:UITextAlignmentCenter];
		}else if ([indexPath row] == 1) {
			cell.accessoryType = UITableViewCellAccessoryNone;
			[cell.textLabel setText:@"Clear Jokes"];
			[cell.textLabel setTextAlignment:UITextAlignmentCenter];
		}
		
	}
	
	[cell setSelectionStyle:UITableViewCellSelectionStyleGray];
	
	return cell;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/


/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:YES];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/


/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/


/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/



#pragma mark -
#pragma mark Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	// Navigation logic may go here. Create and push another view controller.

	if([indexPath section] == 0){
	 phraseDetail *detailViewController = [[phraseDetail alloc] initWithNibName:@"phraseDetail" bundle:nil];
	
	// Pass the selected object to the new view controller. //
	
	//Set the mode to "Edit"
	detailViewController.mode = @"edit";
	//save the phrase in title bar
	detailViewController.phrase = [[[self.tableView cellForRowAtIndexPath:indexPath] textLabel] text];
	//pass the ID of the selected item
	detailViewController.phraseID = [[NSNumber alloc] initWithUnsignedInteger:[indexPath row]];
	//set the title of the editor
	detailViewController.title = [NSString stringWithFormat:@"Edit: %@", detailViewController.phrase];
	//pushthe view controller
	[self.navigationController pushViewController:detailViewController animated:YES];
	//release the un-needed copy of the view controller
	}else if ([indexPath section] == 1) {
		if ([indexPath row] == 0) {
			UIAlertView  *a = [[UIAlertView alloc] initWithTitle:@"" message:@"Are you sure that you want to restore the orignal phrases? This will delete any phrases or To Do items which you may have added." delegate:self cancelButtonTitle:@"Nope." otherButtonTitles: nil];
			[a setTag:0];
			[a addButtonWithTitle:@"Yes, please."];
			[a show];
		}else if ([indexPath row] == 1) {
			UIAlertView  *a = [[UIAlertView alloc] initWithTitle:@"" message:@"Are you sure that you want to clear all the phrases?" delegate:self cancelButtonTitle:@"No, thank you." otherButtonTitles: nil];
			[a setTag:1];
			[a addButtonWithTitle:@"Yes, I am."];
			[a show];
		}
	}

}

#pragma mark -
#pragma mark Reload Original phrases

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex{
	if(buttonIndex == 1){
		if (alertView.tag == 0) {
			[self restorePhrases];
		}else if (alertView.tag == 1) {
			[self clearPhrases];
		}
	}
	[self.tableView deselectRowAtIndexPath:[self.tableView indexPathForSelectedRow] animated:NO];
}

- (void) restorePhrases{
	NSArray *tempreplies = [[NSMutableArray alloc] initWithContentsOfFile:[[NSBundle mainBundle]pathForResource:@"ShakenList" ofType:@"plist"]];
	[[NSUserDefaults standardUserDefaults] setObject:tempreplies forKey:@"customphrases"];
	
	self.phrases = [[NSArray alloc] initWithArray:[[NSUserDefaults standardUserDefaults] objectForKey:@"customphrases"]];
	[self.tableView reloadData];
}

- (void) clearPhrases{
	NSArray *tempreplies = [[NSMutableArray alloc] initWithObjects:@"Edit this task, or add your own.", nil];
	[[NSUserDefaults standardUserDefaults] setObject:tempreplies forKey:@"customphrases"];
	
	self.phrases = [[NSArray alloc] initWithArray:[[NSUserDefaults standardUserDefaults] objectForKey:@"customphrases"]];
	[self.tableView reloadData];
}

#pragma mark -
#pragma mark Memory management

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Relinquish ownership any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
    // Relinquish ownership of anything that can be recreated in viewDidLoad or on demand.
    // For example: self.myOutlet = nil;
}




@end

