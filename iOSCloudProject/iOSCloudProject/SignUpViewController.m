//
//  SignUpViewController.m
//  iOSCloudProject
//
//  Created by Weiqi An on 12/22/14.
//  Copyright (c) 2014 Weiqi An. All rights reserved.
//


#import "AppDelegate.h"
#import "SignUpViewController.h"

@interface SignUpViewController ()

@end

@implementation SignUpViewController

UITextField* nameField;
UITextField* emailField;
UITextField* passwordField;

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationController setNavigationBarHidden:NO];
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    self.view.backgroundColor = [UIColor colorWithRed:(247/255.0) green:(247/255.0) blue:(247/255.0) alpha:1];
    UIBarButtonItem *createButton = [[UIBarButtonItem alloc]
                                   initWithTitle:@"Create"
                                   style:UIBarButtonSystemItemDone
                                   target:self
                                   action:@selector(createAccount)];
    self.navigationItem.rightBarButtonItem = createButton;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)createAccount{
    
    NSURLComponents *components = [NSURLComponents componentsWithString:@"http://localhost:2015/user"];
    NSDictionary *queryDictionary = @{ @"email": emailField.text, @"password": passwordField.text, @"name": nameField.text};
    NSMutableArray *queryItems = [NSMutableArray array];
    for (NSString *key in queryDictionary) {
        [queryItems addObject:[NSURLQueryItem queryItemWithName:key value:queryDictionary[key]]];
    }
    components.queryItems = queryItems;
    NSURL *url = components.URL;
    
    NSLog(@"%@",url);
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setHTTPMethod:@"POST"];
    [request setURL:url];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    
    NSError *error = [[NSError alloc] init];
    NSHTTPURLResponse *responseCode = nil;
    
    NSData *oResponseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&responseCode error:&error];
    
        NSString *result = [[NSString alloc] initWithData:oResponseData encoding:NSUTF8StringEncoding];
        NSDictionary* jsonObject = [NSJSONSerialization JSONObjectWithData:[result dataUsingEncoding:NSUTF8StringEncoding] options:0 error:NULL];
    
        if(jsonObject[@"error"] == 0){
            NSLog(@"%@", @"yesssss");
        }else{
        }
    
        NSLog(@"%@", jsonObject);
    
    if([responseCode statusCode] != 200){
        NSLog(@"Error getting %@, HTTP status code %i", url, (int)[responseCode statusCode]);
        NSLog(@"%@", oResponseData);
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                        message:@"Error checkin"
                                                       delegate:self
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
    }else{
        AppDelegate* appDelegate = [UIApplication sharedApplication].delegate;
        [appDelegate userloggedIn];
    }
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)aTableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)aTableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}

- (CGFloat)tableView:(UITableView*)tableView heightForHeaderInSection:(NSInteger)section
{
    return 50;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return @"Create Account";
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"signup"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] init];
        //cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    cell.detailTextLabel.hidden = YES;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    if(indexPath.row == 0){
        nameField = [[UITextField alloc] initWithFrame:CGRectMake(120, 10, 220, 30)];
        nameField.tag = 3;
        nameField.translatesAutoresizingMaskIntoConstraints = NO;
        
        nameField.textAlignment = NSTextAlignmentLeft;
        nameField.delegate = self;
        cell.textLabel.text = @"Full Name";
        nameField.placeholder = @"Full Name";
        [cell.contentView addSubview:nameField];
    }else if(indexPath.row == 1){
        emailField = [[UITextField alloc] initWithFrame:CGRectMake(120, 10, 220, 30)];
        emailField.tag = 3;
        emailField.translatesAutoresizingMaskIntoConstraints = NO;
        
        emailField.textAlignment = NSTextAlignmentLeft;
        emailField.delegate = self;
        cell.textLabel.text = @"Email";
        emailField.placeholder = @"Email Address";
        [cell.contentView addSubview:emailField];
    }else {
        passwordField = [[UITextField alloc] initWithFrame:CGRectMake(120, 10, 220, 30)];
        passwordField.tag = 3;
        passwordField.translatesAutoresizingMaskIntoConstraints = NO;
        
        passwordField.textAlignment = NSTextAlignmentLeft;
        passwordField.delegate = self;
        cell.textLabel.text = @"Password";
        passwordField.placeholder = @"Password";
        passwordField.secureTextEntry = YES;
        [cell.contentView addSubview:passwordField];
    }

//    [[cell viewWithTag:3] removeFromSuperview];
    
    return cell;
}

@end
