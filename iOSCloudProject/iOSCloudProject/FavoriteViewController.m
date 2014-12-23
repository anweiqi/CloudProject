//
//  FavoriteViewController.m
//  iOSCloudProject
//
//  Created by Weiqi An on 11/15/14.
//  Copyright (c) 2014 Weiqi An. All rights reserved.
//

#import "FavoriteViewController.h"
#import "FavoriteTableViewCell.h"
#import "FriendModel.h"

@interface FavoriteViewController ()



@end

@implementation FavoriteViewController

- (id)init {
    self = [super init];
    if (self) {
        self.title = NSLocalizedString(@"Special List", @"Favorites");
        self.tabBarItem = [[UITabBarItem alloc] initWithTabBarSystemItem:UITabBarSystemItemFavorites tag:1];
        
        //[UIImage imageNamed:@"settings.png"];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UISearchBar *searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0.0, 0.0, 375.0, 44.0)];
    
    searchBar.searchBarStyle = UISearchBarStyleMinimal;
    
    // create the Search Display Controller with the above Search Bar
    self.searchController = [[UISearchDisplayController alloc]initWithSearchBar:searchBar contentsController:self];
    self.searchController.searchResultsDataSource = self;
    self.searchController.searchResultsDelegate = self;
    //[self.tableView setContentOffset:CGPointMake(0,44) animated:YES];
    self.tableView.tableHeaderView = searchBar;
    
    self.tableView.allowsMultipleSelectionDuringEditing = NO;

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)aTableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)aTableView numberOfRowsInSection:(NSInteger)section {
    NSLog(@"count");
    return self.data.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"cell");

    static NSString *CellIdentifier = @"CellIdentifier";
    FriendModel *item = [self.data objectAtIndex:indexPath.row];
    
    // Dequeue or create a cell of the appropriate type.
    FavoriteTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[FavoriteTableViewCell alloc] init];
        //cell.accessoryType = UITableViewCellAccessoryNone;
    }
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
        NSData *imageData = [NSData dataWithContentsOfURL:item.image];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            // Update the UI
            [cell.profileImageView setImage:[UIImage imageWithData:imageData]];
        });
    });
    
    cell.nameLabel.text = item.name;
    NSString *location = [self.friendlist.friendsLocation objectForKey:item.email];
    NSString *time = [self.friendlist.friendsTime objectForKey:item.email];
    NSString *locationtime = @"";
    if (location != nil)
        locationtime = [NSString stringWithFormat:@"%@ / %@", location, time];
    cell.placeLabel.text = locationtime;
    
    // Configure the cell.
    //cell.textLabel.text = [NSString stringWithFormat:@"Row %d: %@", indexPath.row, [_data objectAtIndex:indexPath.row]];
    return cell;
}

// Override to support conditional editing of the table view.
// This only needs to be implemented if you are going to be returning NO
// for some items. By default, all items are editable.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return YES if you want the specified item to be editable.
    return YES;
}

// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        //add code here for when you hit delete
        FriendModel *friend = [self.data objectAtIndex:indexPath.row];
        [self.data removeObjectAtIndex:indexPath.row];
        [self.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
        [self.friendlist deleteFriends:friend.email];
    }
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewCellEditingStyleDelete;
}



@end
