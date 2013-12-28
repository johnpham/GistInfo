//
//  ViewController.m
//  GistInfo
//
//  Created by John Pham on 12/16/13.
//  Copyright (c) 2013 John Pham. All rights reserved.
//

#import "ViewController.h"
#import "GistInfomation.h"
#import "Gist.h"

@interface ViewController ()

@end

//#import "ViewController.h"

NSString *const username = @"johnpham";
NSString *const password = @"2007gti";

@interface ViewController ()

//NSURLSession use to make our remote fetch
@property (strong,nonatomic) NSURLSession *session;
//store gist description or commit id if descriptions are empty.  This property is use to populate the tables
@property (strong,nonatomic) NSMutableArray *description;
@property (nonatomic,retain) UIRefreshControl *refreshControl;
@property(nonatomic, retain) UITableView *tableView;

@end


@implementation ViewController
{
    NSMutableArray *_items;

}



//-(IBAction)AddItem{
//    
//}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    NSLog(@"%i",self.description.count);
    //return [_items count];

    return self.description.count;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    //CellWithIdentifier defined in our interface builder
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    // Configure the cell to display the description that we have in our description array
    Gist *gist = self.description[indexPath.row];
    cell.textLabel.text = gist.gistId;
    return cell;
}


- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        //configure authentication for all future session task
        NSURLSessionConfiguration *defaultConfigObject = [NSURLSessionConfiguration defaultSessionConfiguration];
        //use basic authentication to login to gist
        NSString *userPasswordString = [NSString stringWithFormat:@"%@:%@", username, password];
        NSData * userPasswordData = [userPasswordString dataUsingEncoding:NSUTF8StringEncoding];
        NSString *base64EncodedCredential = [userPasswordData base64EncodedStringWithOptions:0];
        NSString *authString = [NSString stringWithFormat:@"Basic %@", base64EncodedCredential];
        NSLog(@"Basic %@", base64EncodedCredential);
        //set the authentication username/password in the http header so that all future session tasks can use it as part of the configuration
        [defaultConfigObject setHTTPAdditionalHeaders:@{@"Authorization": authString}];
        self.session = [NSURLSession sessionWithConfiguration: defaultConfigObject delegate: nil delegateQueue: [NSOperationQueue mainQueue]];
        //init description array
        self.description = [[NSMutableArray alloc]init];
    }
    return self;
}




- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _items = [[NSMutableArray alloc] initWithCapacity:20];

    
	// Do any additional setup after loading the view, typically from a nib.
    //create a pull down in the table to refresh manually
    UIRefreshControl *refresh = [[UIRefreshControl alloc] init];
    refresh.attributedTitle = [[NSAttributedString alloc] initWithString:@"Pull to Refresh"];
    //call listGist method when the user pulls down past the tables
    [refresh addTarget:self action:@selector(listGist) forControlEvents:UIControlEventValueChanged];
    self.refreshControl = refresh;
    //make rest call to get the gists
    [self listGist];
}

//Method use to fetch data from gist via json rest call.  This method will also populate the tables
-(void)listGist {
    //show network is busy
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    //reset the array to empty
    [self.description removeAllObjects];
    //make call to gist using the username const that we defined
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"https://api.github.com/users/%@/gists", username]]];
    [request setHTTPMethod:@"GET"];
    
    //make call to retrieve data
    [[self.session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        //check for retrieve errors. if there are no errors get the json data
        if(error == nil) {
            NSHTTPURLResponse *httpResp = (NSHTTPURLResponse*) response;
            //response is 200 so data is OK, if any other code other than 200, we want to display error alert
            if (httpResp.statusCode == 200) {
                NSError *jsonError;
                
                NSMutableArray *notesJSON =
                [NSJSONSerialization JSONObjectWithData:data
                                                options:NSJSONReadingAllowFragments
                                                  error:&jsonError];
                //check to make sure that we are gettting json data back
                if (jsonError == nil) {
                    //json data is good so loop through all the data returned from the response
                    for (NSDictionary *key in notesJSON) {
                        //get the json description if it exist, if not, get the json commit id and populate it in the
                        Gist *gist = [[Gist alloc]init];
                        
                        gist.gistId = key[@"id"];
                        gist.description = key[@"description"];
                        gist.forkUrl = key[@"forks_url"];
                        [self.description addObject:gist];
                    }
                    
                    //refresh the table with new data we got from gist
                    dispatch_async(dispatch_get_main_queue(), ^{
                        //reload the table
                        [self.tableView reloadData];
                        //turn off network indicator progress indicator
                        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
                        //turn off refreshControl progress indicator
                        [self.refreshControl endRefreshing];
                    });
                    //do error handling by showing the alert with msg
                } else { //json error so display an alert
                    NSString *jsonErrMsg = [NSString stringWithFormat:@"json error %@", jsonError];
                    UIAlertView *message = [[UIAlertView alloc] initWithTitle:@"Json Error" message:jsonErrMsg delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
                    [message show];
                }
            } else { //http error
                NSString *httpErrMsg = [NSString stringWithFormat:@"HTTP error code %i %@", error.code, error];
                UIAlertView *message = [[UIAlertView alloc] initWithTitle:@"HTTP Error" message:httpErrMsg delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
                [message show];
            }
        } else { //unknown error
            NSString *ErrMsg = [NSString stringWithFormat:@"Error %@", error];
            UIAlertView *message = [[UIAlertView alloc] initWithTitle:@"Error" message:ErrMsg delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [message show];
        }
    }] resume];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"EditItem"])
    {
        UINavigationController *navigationController = segue.destinationViewController;
        // Get reference to the destination view controller
        GistInfomation *dvc = (GistInfomation*)navigationController.topViewController;
        // Pass any objects to the view controller here, like...
        NSIndexPath *path = [self.tableView indexPathForSelectedRow];
        Gist *gist = self.description[path.row];
        dvc.editGist = gist;
    }
    if ([segue.identifier isEqualToString:@"AddItem"])
    {
        // 1
        UINavigationController *navigationController = segue.destinationViewController;
        // 2
        CreateNewGistViewController *controller = (CreateNewGistViewController *)
        navigationController.topViewController;
        controller.delegate = self;
    }
    
}

- (void)addItemViewControllerDidCancel:
(CreateNewGistViewController *)controller
{
    [self dismissViewControllerAnimated:YES completion:nil];
}


- (void)addItemViewController:(CreateNewGistViewController *)controller didFinishAddingItem:(Gist *)item
{
    
NSInteger newRowIndex = [_items count];
[_items addObject:item];
NSIndexPath *indexPath = [NSIndexPath
                          indexPathForRow:newRowIndex inSection:0];
NSArray *indexPaths = @[indexPath];
    [self.tableView insertRowsAtIndexPaths:indexPaths
                                withRowAnimation:UITableViewRowAnimationAutomatic];
    
    [self dismissViewControllerAnimated:YES completion:nil];
}




#pragma mark - Table view data source
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//    // Return the number of rows in the section.
//    return self.description.count;
//}
//
//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//    //CellWithIdentifier defined in our interface builder
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
//    
//    // Configure the cell to display the description that we have in our description array
//    cell.textLabel.text = self.description[indexPath.row];
//    return cell;
//}

@end
