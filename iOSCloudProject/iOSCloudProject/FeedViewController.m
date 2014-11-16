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

@interface FeedViewController ()

@property (strong, nonatomic) UITableView *newsTableView;
@property (strong, nonatomic) NSArray *data;

@end

@implementation FeedViewController

- (id)init {
    self = [super init];
    if (self) {
        self.title = NSLocalizedString(@"News Feed", @"News Feed");
        self.tabBarItem.image = [UIImage imageNamed:@"news.png"];
        self.data = @[[[NSDictionary alloc] initWithObjectsAndKeys:
                       @"Weiqi An", @"name",
                       @"weiqi.jpg", @"image",
                       @"facebook_icon.png", @"source",
                       @"5 mins", @"time",
                       @"Hey, look at what I got - with Jennifer Shih", @"content",
                       nil],
                      [[NSDictionary alloc] initWithObjectsAndKeys:
                       @"Nick DeGiacomo", @"name",
                       @"nick.jpg", @"image",
                       @"twitter_icon.png", @"source",
                       @"30 mins", @"time",
                       @"Nice! So happy they got Stephan Hawkin to voice himself in the \"The Theory of Everything!\"", @"content",
                       nil],
                      [[NSDictionary alloc] initWithObjectsAndKeys:
                       @"John Chaiyasarikul", @"name",
                       @"john.jpg", @"image",
                       @"facebook_icon.png", @"source",
                       @"1 hr", @"time",
                       @"Congratulations to my friends and everyone graduating today at Columbia University!!!!", @"content",
                       nil],
                      [[NSDictionary alloc] initWithObjectsAndKeys:
                       @"Jiuyang Zhao", @"name",
                       @"jiuyang.jpg", @"image",
                       @"g+.png", @"source",
                       @"3 hrs", @"time",
                       @"Intel makes it looks like a nuclear weapon unboxing", @"content",
                       nil],
                      [[NSDictionary alloc] initWithObjectsAndKeys:
                       @"Jiuyang Zhao", @"name",
                       @"jiuyang.jpg", @"image",
                       @"g+.png", @"source",
                       @"4 hrs", @"time",
                       @"Missed the first alarm and first class in my first day.", @"content",
                       nil],
                      [[NSDictionary alloc] initWithObjectsAndKeys:
                       @"Hongji Yang", @"name",
                       @"hongji.jpg", @"image",
                       @"twitter_icon.png", @"source",
                       @"1 day", @"time",
                       @"The happiest place in the world!", @"content",
                       nil]];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    UISearchBar *searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0.0, 0.0, 375.0, 44.0)];
    
    searchBar.searchBarStyle = UISearchBarStyleMinimal;
    
    // create the Search Display Controller with the above Search Bar
    self.searchController = [[UISearchDisplayController alloc]initWithSearchBar:searchBar contentsController:self];
    self.searchController.searchResultsDataSource = self;
    self.searchController.searchResultsDelegate = self;
    //[self.tableView setContentOffset:CGPointMake(0,44) animated:YES];
    self.tableView.tableHeaderView = searchBar;
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *item = [self.data objectAtIndex:indexPath.row];
    UITextView *content = [[UITextView alloc] init];
    [content setFont:[UIFont fontWithName:@"HelveticaNeue" size:13]];
    [content setText:item[@"content"]];
    //[_content setFrame:CGRectMake(15.0, 40.0, 345.0, 60.0)];
    CGFloat fixedWidth = 345;
    CGSize newSize = [content sizeThatFits:CGSizeMake(fixedWidth, MAXFLOAT)];
    
    NSLog(@"%f",newSize.height);
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
    NSDictionary *item = [self.data objectAtIndex:indexPath.row];
    
    // Dequeue or create a cell of the appropriate type.
    FeedTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[FeedTableViewCell alloc] init];
        //cell.accessoryType = UITableViewCellAccessoryNone;
    }
    
    [cell.profileImageView setImage:[UIImage imageNamed:item[@"image"]]];
    [cell.sourceImageView setImage:[UIImage imageNamed:item[@"source"]]];
    cell.nameLabel.text = item[@"name"];
    cell.timeLabel.text = item[@"time"];
    cell.content.text= item[@"content"];
    
    //cell.imageView.image=[UIImage imageNamed:@"map_marker.png"];
    //cell.textLabel.text=@"This is a cell";
    //cell.detailTextLabel.text=@"This is a subtitle";
    
    // Configure the cell.
    //cell.textLabel.text = [NSString stringWithFormat:@"Row %d: %@", indexPath.row, [_data objectAtIndex:indexPath.row]];
    return cell;
}

@end
