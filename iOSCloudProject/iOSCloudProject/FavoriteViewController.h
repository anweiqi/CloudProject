//
//  FavoriteViewController.h
//  iOSCloudProject
//
//  Created by Weiqi An on 11/15/14.
//  Copyright (c) 2014 Weiqi An. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FriendListModel.h"
#import "AddFriendViewController.h"

@interface FavoriteViewController : UITableViewController

@property (strong, nonatomic) NSMutableArray *data;
@property (strong, nonatomic) UISearchDisplayController *searchController;
@property (strong, nonatomic) FriendListModel *friendlist;

@end
