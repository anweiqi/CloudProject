//
//  LoginViewController.m
//  iOSCloudProject
//
//  Created by Weiqi An on 11/9/14.
//  Copyright (c) 2014 Weiqi An. All rights reserved.
//

#import <FacebookSDK/FacebookSDK.h>
#import <GoogleOpenSource/GTLPlusConstants.h>
#import <GooglePlus/GPPSignInButton.h>
#import "AppDelegate.h"
#import "LoginViewController.h"
#import "LoginView.h"
#import "SignUpViewController.h"
#import "UserSession.h"

@interface LoginViewController ()

@end

static NSString * const kClientId = @"814816072679-6hfkd2q1n8b8slh21e0uie5ctgt0gkpo.apps.googleusercontent.com";

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _loginView = [[LoginView alloc] init];
    _loginView.delegate = self;
    self.view = _loginView;
    [self.navigationController setNavigationBarHidden:YES];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
                                   initWithTarget:self
                                   action:@selector(dismissKeyboard)];
    
    [self.view addGestureRecognizer:tap];
    
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated{
    [self.navigationController setNavigationBarHidden:YES];
}

- (void)finishedWithAuth: (GTMOAuth2Authentication *)auth
                   error: (NSError *) error
{
    if (error) {
        NSLog(@"%@",error);
    } else {
        AppDelegate* appDelegate = [UIApplication sharedApplication].delegate;
        //[self storeUser];
        // Call the app delegate's sessionStateChanged:state:error method to handle session state changes
        [appDelegate userloggedIn];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)dismissKeyboard {
    [_loginView.emailTextField resignFirstResponder];
    [_loginView.passwordTextField resignFirstResponder];
}

- (void) myLoginTapped{
    NSLog(@"%@",_loginView.emailTextField.text);
    NSLog(@"The PW is !!!%@", _loginView.passwordTextField.text);
    
    NSURLComponents *components = [NSURLComponents componentsWithString:@"http://129.236.214.233:2015/login"];
    NSDictionary *queryDictionary = @{ @"email": _loginView.emailTextField.text, @"password": _loginView.passwordTextField.text};
    
    NSMutableArray *queryItems = [NSMutableArray array];
    for (NSString *key in queryDictionary) {
        [queryItems addObject:[NSURLQueryItem queryItemWithName:key value:queryDictionary[key]]];
    }
    components.queryItems = queryItems;
    NSURL *url = components.URL;
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setHTTPMethod:@"GET"];
    [request setURL:url];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    
    NSError *error = [[NSError alloc] init];
    NSHTTPURLResponse *responseCode = nil;
    
    NSData *oResponseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&responseCode error:&error];
    NSString *result = [[NSString alloc] initWithData:oResponseData encoding:NSUTF8StringEncoding];
    NSDictionary* jsonObject = [NSJSONSerialization JSONObjectWithData:[result dataUsingEncoding:NSUTF8StringEncoding] options:0 error:NULL];
    
    if([responseCode statusCode] != 200){
        NSLog(@"Error getting %@, HTTP status code %i", url, (int)[responseCode statusCode]);
        NSLog(@"%@", oResponseData);
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                        message:@"Incorrect Email/Password. Please Try Again."
                                                       delegate:self
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
    }else{
        [UserSession storeLoggedinUser:jsonObject];
        AppDelegate* appDelegate = [UIApplication sharedApplication].delegate;
        [appDelegate userloggedIn];
    }

}

- (void) mySignUpTapped{
    SignUpViewController *signUpViewController = [[SignUpViewController alloc] init];
    //[self presentViewController:signUpViewController animated:YES completion:nil];
    [self.navigationController pushViewController:signUpViewController animated:YES];
}

- (void) loginTapped{
    
    // If the session state is any of the two "open" states when the button is clicked
    if (FBSession.activeSession.state == FBSessionStateOpen
        || FBSession.activeSession.state == FBSessionStateOpenTokenExtended) {
        
        // Close the session and remove the access token from the cache
        // The session state handler (in the app delegate) will be called automatically
        [FBSession.activeSession closeAndClearTokenInformation];
        
        // If the session state is not any of the two "open" states when the button is clicked
    } else {
        // Open a session showing the user the login UI
        // You must ALWAYS ask for public_profile permissions when opening a session
        [FBSession openActiveSessionWithReadPermissions:@[@"read_stream, user_likes, user_friends, email, public_profile"]
                                           allowLoginUI:YES
                                      completionHandler:
         ^(FBSession *session, FBSessionState state, NSError *error) {
             
             // Retrieve the app delegate
             AppDelegate* appDelegate = [UIApplication sharedApplication].delegate;
             // Call the app delegate's sessionStateChanged:state:error method to handle session state changes
             [appDelegate sessionStateChanged:session state:state error:error];
         }];
    }
}

- (void) gloginTapped{
    GPPSignIn *signIn = [GPPSignIn sharedInstance];
    signIn.clientID = kClientId;
    signIn.scopes = [NSArray arrayWithObjects:
                     kGTLAuthScopePlusLogin, // 在 GTLPlusConstants.h 中定义
                     nil];
    signIn.actions = [NSArray arrayWithObjects:@"http://schemas.google.com/ListenActivity",nil];
    signIn.delegate = self;
    [signIn authenticate];
    
    //[signIn trySilentAuthentication];
}


@end
