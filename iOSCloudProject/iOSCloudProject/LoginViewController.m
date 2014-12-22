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

@interface LoginViewController ()

@end

static NSString * const kClientId = @"814816072679-6hfkd2q1n8b8slh21e0uie5ctgt0gkpo.apps.googleusercontent.com";

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    LoginView *loginView = [[LoginView alloc] init];
    loginView.delegate = self;
    self.view = loginView;
    
    // Do any additional setup after loading the view.
}

- (void)finishedWithAuth: (GTMOAuth2Authentication *)auth
                   error: (NSError *) error
{
    if (error) {
        NSLog(@"%@",error);
    } else {
        AppDelegate* appDelegate = [UIApplication sharedApplication].delegate;
        // Call the app delegate's sessionStateChanged:state:error method to handle session state changes
        [appDelegate userloggedIn];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) loginTapped: (NSString*) email password: (NSString*) password{
    
    NSLog(@"email!!!!!!!%@", self.emailTextField.text);
    // If the session state is any of the two "open" states when the button is clicked
}

- (void) loginTapped{
    
    NSLog(@"email!!!!!!!%@", self.emailTextField.text);
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
