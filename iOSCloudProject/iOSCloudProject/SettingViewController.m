//
//  SettingViewController.m
//  iOSCloudProject
//
//  Created by Weiqi An on 11/13/14.
//  Copyright (c) 2014 Weiqi An. All rights reserved.
//

#import "SettingViewController.h"

@interface SettingViewController ()

@end

@implementation SettingViewController

- (id)init {
    self = [super init];
    if (self) {
        self.title = NSLocalizedString(@"Settings", @"Settings");
        self.tabBarItem.image = [UIImage imageNamed:@"settings.png"];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)aTableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)aTableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 4;
    } else {
        return 4;
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
        return @"Social Accounts";
    }
    return @"";
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"CellIdentifier";
    
    // Dequeue or create a cell of the appropriate type.
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] init];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        //cell.accessoryType = UITableViewCellAccessoryNone;
    }
    
    // Configure the cell.
    //cell.textLabel.text = [NSString stringWithFormat:@"Row %d: %@", indexPath.row, [_data objectAtIndex:indexPath.row]];
    return cell;
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
