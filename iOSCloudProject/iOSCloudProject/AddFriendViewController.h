//
//  AddFriendViewController.h
//  iOSCloudProject
//
//  Created by Jiuyang Zhao on 14/12/23.
//  Copyright (c) 2014年 Weiqi An. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FriendListModel.h"

@interface AddFriendViewController : UITableViewController <UIAlertViewDelegate>

@property (strong, nonatomic) UITableViewController *favoriteViewController;
@property (strong, nonatomic) FriendListModel *friendlist;

@end
