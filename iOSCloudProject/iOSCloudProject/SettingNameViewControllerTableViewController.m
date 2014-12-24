//
//  SettingNameViewControllerTableViewController.m
//  iOSCloudProject
//
//  Created by Jiuyang Zhao on 14/12/23.
//  Copyright (c) 2014年 Weiqi An. All rights reserved.
//

#import "SettingNameViewControllerTableViewController.h"

@interface SettingNameViewControllerTableViewController ()

@end

@implementation SettingNameViewControllerTableViewController

UITextField* nameField;

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationController setNavigationBarHidden:NO];
    self.title = @"Change Name";
    UIBarButtonItem *createButton = [[UIBarButtonItem alloc]
                                     initWithTitle:@"Save"
                                     style:UIBarButtonSystemItemDone
                                     target:self
                                     action:@selector(saveName)];
    self.navigationItem.rightBarButtonItem = createButton;
    
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    self.view.backgroundColor = [UIColor colorWithRed:(247/255.0) green:(247/255.0) blue:(247/255.0) alpha:1];
    self.tableView.separatorColor = [UIColor clearColor];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)saveName{
    
    int response = [self.user setUser:nameField.text password:self.user.password];
    
    if(response != 200){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                        message:@"Error Setting Name"
                                                       delegate:self
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
    }else{
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Succeed"
                                                        message:@"Name Changed"
                                                       delegate:self
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (CGFloat)tableView:(UITableView*)tableView heightForHeaderInSection:(NSInteger)section
{
    return 40;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return 1;
}

- (void) exit{
    [self dismissModalViewControllerAnimated:YES];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"settingname"];
    
    // Configure the cell...
    if (cell == nil) {
        cell = [[UITableViewCell alloc] init];
        //cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    cell.detailTextLabel.hidden = YES;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    nameField = [[UITextField alloc] initWithFrame:CGRectMake(120, 10, 220, 30)];
    nameField.tag = 3;
    nameField.translatesAutoresizingMaskIntoConstraints = NO;
    
    nameField.textAlignment = NSTextAlignmentLeft;
    nameField.delegate = self;
    cell.textLabel.text = @"Full Name";
    nameField.placeholder = @"Full Name";
    [cell.contentView addSubview:nameField];
    
    return cell;
}

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex {
    if ([alertView.title isEqualToString:@"Succeed"]) {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

@end
