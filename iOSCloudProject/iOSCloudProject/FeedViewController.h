//
//  FeedViewController.h
//  iOSCloudProject
//
//  Created by Weiqi An on 11/13/14.
//  Copyright (c) 2014 Weiqi An. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FeedListModel.h"

@interface FeedViewController : UITableViewController <UISearchBarDelegate, UISearchDisplayDelegate, UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) UISearchDisplayController *searchController;
@property (strong, nonatomic) UISearchBar *searchBar;
@property (strong, nonatomic) NSMutableArray *data;
@property (strong, nonatomic) FeedListModel *feedList;


@end
