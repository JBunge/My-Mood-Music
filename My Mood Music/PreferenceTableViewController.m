//
//  PreferenceTableViewController.m
//  My Mood Music
//
//  Created by Kartik Sawant on 10/25/14.
//  Copyright (c) 2014 Kartik Sawant. All rights reserved.
//

#import "PreferenceTableViewController.h"
#import "ASIHTTPRequest.h"

@interface PreferenceTableViewController ()

@end

@implementation PreferenceTableViewController
NSArray *valueArray;
- (void)viewDidLoad {
    [super viewDidLoad];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://soundcloud.com/connect?state=SoundCloud_Dialog_8d64e&client_id=1ca7a448b3e22d42b5b650ba1c009e7d&redirect_uri=mymoodmusic://soundcloud&response_type=code_and_token&scope=non-expiring"]];
    //http:
    //data.cs.purdue.edu:8182/login/?code=114cd623c0bf09502849c2ebec288f8a&client_id=1ca7a448b3e22d42b5b650ba1c009e7d&client_secret=cb26429712333876d0d1b0c0968d9250&redirect_uri=mymoodmusic://soundcloud
    //http:
    //data.cs.purdue.edu:8182/me/?auth_token=1-101815-119835817-98b12a635adfb
    //auth_token=1-101815-119835817-98b12a635adfb
    //id=119835817
    self.tableView.editing = YES;
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return 12;
}

- (IBAction)grabURLInBackground:(id)sender
{
   //Get the stored data before the view loads
   NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
     
   NSString *username = [defaults objectForKey:@"username"];
	
   NSURL *url = [NSURL URLWithString:@"http://web.ics.purdue.edu/~bunge/mymood.php?todo=getP&username="+ username];
   ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
   [request setDelegate:self];
   [request startAsynchronous];
}
 
- (void)requestFinished:(ASIHTTPRequest *)request
{
   // Use when fetching text data
   NSString *responseString = [request responseString];
   
   valueArray = [responseString componentsSeparatedByString:@"|"];
   //NSString *works = [valueArray objectAtIndex:0];
}
 
- (void)requestFailed:(ASIHTTPRequest *)request
{
   NSError *error = [request error];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
	for(int i=0; i<=11; i++){
		if (indexPath.row == i) {
			cell.textLabel.text = [valueArray objectAtIndex:i];
		}
	}
    
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
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
    //[tableView cellForRowAtIndexPath:fromIndexPath].textLabel.text
}

// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}

/*
#pragma mark - Navigation
// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
