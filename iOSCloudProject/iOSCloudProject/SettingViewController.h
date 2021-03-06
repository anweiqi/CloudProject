//
//  SettingViewController.h
//  iOSCloudProject
//
//  Created by Weiqi An on 11/13/14.
//  Copyright (c) 2014 Weiqi An. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "UserModel.h"
#import "SettingNameViewControllerTableViewController.h"

@interface SettingViewController : UITableViewController <UIAlertViewDelegate>

@property (nonatomic, strong) UserModel *user;

@end
