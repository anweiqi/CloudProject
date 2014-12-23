//
//  SettingViewController.m
//  iOSCloudProject
//
//  Created by Weiqi An on 11/13/14.
//  Copyright (c) 2014 Weiqi An. All rights reserved.
//

#import "SettingViewController.h"
#import "SettingTableViewCell.h"
#import "UserSession.h"
#import "AppDelegate.h"

@interface SettingViewController ()

@end

@implementation SettingViewController

NSDictionary * currentUser;

- (id)init {
    self = [super init];
    if (self) {
        self.title = NSLocalizedString(@"Settings", @"Settings");
        self.tabBarItem.image = [UIImage imageNamed:@"settings.png"];
        UIBarButtonItem *addButton = [[UIBarButtonItem alloc]
                                      initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh
                                      target:self action:@selector(getLatestFeeds)];
        self.navigationItem.rightBarButtonItem = addButton;
        currentUser = [UserSession getLoggedinUser];
        self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
        self.view.backgroundColor = [UIColor colorWithRed:(247/255.0) green:(247/255.0) blue:(247/255.0) alpha:1];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)getLatestFeeds
{
    
    [self.tableView reloadData];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)aTableView {
    return 3;
}

- (NSInteger)tableView:(UITableView *)aTableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 1;
    } else if (section == 1) {
        return 2;
    } else{
        return 1;
    }
}

- (CGFloat)tableView:(UITableView*)tableView heightForHeaderInSection:(NSInteger)section
{
    return 40;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (section == 0)
    {
        return @"My Account";
    }
    if (section == 1)
    {
        return @"Account Information";
    }
    return @"";
}

- (void)logOut{
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Warning"
                                                    message:@"Are you sure to log out?"
                                                   delegate:self
                                          cancelButtonTitle:@"Cancel"
                                          otherButtonTitles:@"Log Out", nil];
    [alert show];
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    //static NSString *CellIdentifier = @"CellIdentifier";
    
    if (indexPath.section == 0) {
        
        // Dequeue or create a cell of the appropriate type.
        UITableViewCell *cell = [[UITableViewCell alloc] init];
//        if (cell == nil) {
//            cell = [[UITableViewCell alloc] init];
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            //cell.accessoryType = UITableViewCellAccessoryNone;
        //}
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
            NSData *imageData = [NSData dataWithContentsOfURL:self.user.imageUrl];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                // Update the UI
                cell.imageView.image = [UIImage imageWithData:imageData];
            });
        });
        cell.textLabel.text = self.user.email;
        
        return cell;
    } else if (indexPath.section == 1)
    {
        SettingTableViewCell *cell = [[SettingTableViewCell alloc] init];
//        if (cell == nil) {
//            cell = [[SettingTableViewCell alloc] init];
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
       // }
        
        if (indexPath.row == 0) {
            cell.field.text = @"Full Name:";
            cell.content.text = self.user.name;
            cell.content.editable = NO;
            //cell.textLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:10];
        } else if (indexPath.row == 1) {
            cell.field.text = @"password:";
            cell.content.text = @"********";
            cell.content.editable = NO;
        }
        return cell;
    } else {
        UITableViewCell *cell = [[SettingTableViewCell alloc] initWithStyle:UITableViewCellSelectionStyleDefault reuseIdentifier:nil];
        //[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
//        if (cell == nil) {
//            cell = [[SettingTableViewCell alloc] init];
            cell.accessoryType = UITableViewCellAccessoryNone;
        //}
        CGRect screenRect = [[UIScreen mainScreen] bounds];
        CGFloat screenWidth = screenRect.size.width;
        cell.textLabel.text = @"Log Out";
        cell.textLabel.textColor = [UIColor redColor];
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        
        
    } else if (indexPath.section == 1)
    {        
        if (indexPath.row == 0) {
            SettingNameViewControllerTableViewController *settingNameViewControllerTableViewController = [[SettingNameViewControllerTableViewController alloc] init];
            settingNameViewControllerTableViewController.user = self.user;
            //[self presentViewController:signUpViewController animated:YES completion:nil];
            [self.navigationController pushViewController:settingNameViewControllerTableViewController animated:YES];
        } else if (indexPath.row == 1) {
            
        }
    }else if (indexPath.section == 2) {
        [self logOut];
    }
}

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 1) {
        AppDelegate* appDelegate = [UIApplication sharedApplication].delegate;
        [appDelegate userloggedOut];
    }
}

@end
