//
//  FeedViewController.m
//  iOSCloudProject
//
//  Created by Weiqi An on 11/13/14.
//  Copyright (c) 2014 Weiqi An. All rights reserved.
//

#import "FeedViewController.h"
#import "FeedView.h"
#import "FeedTableViewCell.h"
#import "ComposerViewController.h"
#import "ComposerView.h"

#import "FeedListModel.h"
#import "FeedModel.h"
#import "FriendListModel.h"

@interface FeedViewController ()

@property (strong, nonatomic) NSMutableArray *filteredData;

@end

@implementation FeedViewController

- (id)init {
    self = [super init];
    if (self) {
        self.title = NSLocalizedString(@"News Feed", @"News Feed");
        self.tabBarItem.image = [UIImage imageNamed:@"news.png"];
        UIBarButtonItem *addButton = [[UIBarButtonItem alloc]
                                      initWithBarButtonSystemItem:UIBarButtonSystemItemCompose
                                      target:self action:@selector(addButtonPressed)];
        self.navigationItem.rightBarButtonItem = addButton;
        
//        FriendListModel *friendList = [[FriendListModel alloc] init];
//        friendList.me = @"weiqian.pku@gmail.com";
//        
//        //[friendList addFriends:@"jiuyangzhaoaaaaa.sjtu@gmail.com"];
//        
//        FeedListModel *feedList = [[FeedListModel alloc] init];
//        [feedList getFeed:@"weiqian.pku@gmail.com"];
        
        //self.data = feedList.feedList;
        NSLog(@"This is time!!!:%i", (int)CFAbsoluteTimeGetCurrent());
        _filteredData = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)addButtonPressed{
    ComposerViewController *composerViewController = [[ComposerViewController alloc] init];
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:composerViewController];
    [self presentViewController:navigationController animated:YES completion:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0.0, 0.0, 375.0, 44.0)];
    
    self.searchBar.searchBarStyle = UISearchBarStyleMinimal;
    
    // create the Search Display Controller with the above Search Bar
    self.searchController = [[UISearchDisplayController alloc]initWithSearchBar:self.searchBar contentsController:self];
    self.searchController.searchResultsDataSource = self;
    self.searchController.searchResultsDelegate = self;
    self.searchController.delegate = self;
    //[self.tableView setContentOffset:CGPointMake(0,44) animated:YES];
    self.tableView.tableHeaderView = self.searchBar;
    
    // Do any additional setup after loading the view.
    // Initialize the refresh control.
    self.refreshControl = [[UIRefreshControl alloc] init];
    self.refreshControl.backgroundColor = [UIColor whiteColor];
    self.refreshControl.tintColor = [UIColor grayColor];
    [self.refreshControl addTarget:self
                            action:@selector(getLatestFeeds)
                  forControlEvents:UIControlEventValueChanged];
}

- (void)getLatestFeeds
{
        
    [self.feedList getAllFeeds];
    self.data = self.feedList.feedList;
    // As this block of code is run in a background thread, we need to ensure the GUI
    // update is executed in the main thread
    [self performSelectorOnMainThread:@selector(reloadData) withObject:nil waitUntilDone:NO];

}

- (void)reloadData
{
    // Reload table data
    [self.tableView reloadData];
    
    if (self.refreshControl) {
        
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"MMM d, h:mm a"];
        NSString *title = [NSString stringWithFormat:@"Last update: %@", [formatter stringFromDate:[NSDate date]]];
        NSDictionary *attrsDictionary = [NSDictionary dictionaryWithObject:[UIColor whiteColor]
                                                                    forKey:NSForegroundColorAttributeName];
        NSAttributedString *attributedTitle = [[NSAttributedString alloc] initWithString:title attributes:attrsDictionary];
        self.refreshControl.attributedTitle = attributedTitle;
        
        [self.refreshControl endRefreshing];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    FeedModel *item = [self.data objectAtIndex:indexPath.row];
    UITextView *content = [[UITextView alloc] init];
    [content setFont:[UIFont fontWithName:@"HelveticaNeue" size:13]];
    [content setText:item.content];
    //[_content setFrame:CGRectMake(15.0, 40.0, 345.0, 60.0)];
    CGFloat fixedWidth = 345;
    CGSize newSize = [content sizeThatFits:CGSizeMake(fixedWidth, MAXFLOAT)];
    
    //NSLog(@"%f",newSize.height);
    return 50 + newSize.height;
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)aTableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)aTableView numberOfRowsInSection:(NSInteger)section {
    return self.data.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"CellIdentifier";
    FeedModel *item = [self.data objectAtIndex:indexPath.row];
    
    // Dequeue or create a cell of the appropriate type.
    FeedTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[FeedTableViewCell alloc] init];
        //cell.accessoryType = UITableViewCellAccessoryNone;
    }
    
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
        NSData *imageData = [NSData dataWithContentsOfURL:item.imageUrl];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            // Update the UI
            [cell.profileImageView setImage:[UIImage imageWithData:imageData]];
        });
    });
    
    //[cell.profileImageView setImage:[UIImage imageNamed:item[@"image"]]];
    cell.nameLabel.text = item.name;
    cell.timeLabel.text = item.timeliteral;
    cell.content.text= item.content;
    
    //cell.imageView.image=[UIImage imageNamed:@"map_marker.png"];
    //cell.textLabel.text=@"This is a cell";
    //cell.detailTextLabel.text=@"This is a subtitle";
    
    // Configure the cell.
    //cell.textLabel.text = [NSString stringWithFormat:@"Row %d: %@", indexPath.row, [_data objectAtIndex:indexPath.row]];
    return cell;
}

- (void)searchTableList {
    NSString *searchString = self.searchBar.text;
    
    for (FeedModel *feed in self.data) {
        NSString *tempStr = feed.name;
        NSComparisonResult result = [tempStr compare:searchString options:(NSCaseInsensitiveSearch|NSDiacriticInsensitiveSearch) range:NSMakeRange(0, [searchString length])];
        if (result == NSOrderedSame) {
            [self.filteredData addObject:tempStr];
        }
    }
}

- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar {
    //self.isSearching = YES;
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    //NSLog(@"Text change - %d",self.isSearching);
    
    //Remove all objects first.
    [self.filteredData removeAllObjects];
    
    if([searchText length] != 0) {
        //self.isSearching = YES;
        [self searchTableList];
    }
    else {
        //self.isSearching = NO;
    }
    [self.tableView reloadData];
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    NSLog(@"Cancel clicked");
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    NSLog(@"Search Clicked");
    [self searchTableList];
}

@end
