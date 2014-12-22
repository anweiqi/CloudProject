//
//  LoginView.m
//  iOSCloudProject
//
//  Created by Weiqi An on 11/9/14.
//  Copyright (c) 2014 Weiqi An. All rights reserved.
//

#import <FacebookSDK/FacebookSDK.h>
#import <GooglePlus/GPPSignInButton.h>
#import "LoginView.h"

@implementation LoginView

- (id)init {
    self = [super initWithFrame:[[UIScreen mainScreen] bounds]];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        
        //_signInButton = [[GPPSignInButton alloc] initWithFrame:CGRectMake(62, 500, 250, 40)];
    }
    return self;
}

- (void) layoutSubviews{
    
    UIImageView *logo = [[UIImageView alloc] initWithFrame:CGRectMake(62, 100, 250, 70)];
    [logo setImage:[UIImage imageNamed:@"logo.png"]];
    [self addSubview:logo];
    
    UITextField *emailTextField = [[UITextField alloc] initWithFrame:CGRectMake(62, 200, 250, 40)];
    emailTextField.borderStyle = UITextBorderStyleRoundedRect;
    emailTextField.textColor = [UIColor blackColor];
    emailTextField.font = [UIFont systemFontOfSize:15.0];
    emailTextField.placeholder = @"Email";
    emailTextField.backgroundColor = [UIColor clearColor];
    emailTextField.autocorrectionType = UITextAutocorrectionTypeYes;
    emailTextField.keyboardType = UIKeyboardTypeDefault;
    emailTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    emailTextField.delegate = self.delegate;
    
    [self addSubview:emailTextField];
    
    UITextField *passwordTextField = [[UITextField alloc] initWithFrame:CGRectMake(62, 250, 250, 40)];
    passwordTextField.borderStyle = UITextBorderStyleRoundedRect;
    passwordTextField.textColor = [UIColor blackColor];
    passwordTextField.font = [UIFont systemFontOfSize:15.0];
    passwordTextField.placeholder = @"Password";
    passwordTextField.backgroundColor = [UIColor clearColor];
    passwordTextField.autocorrectionType = UITextAutocorrectionTypeYes;
    passwordTextField.keyboardType = UIKeyboardTypeDefault;
    passwordTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    passwordTextField.delegate = self.delegate;
    [self addSubview:passwordTextField];
    
    UIButton *loginButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    loginButton.frame = CGRectMake(62, 300, 250, 40);
    //[loginButton setBackgroundColor:[UIColor blueColor]];
    [loginButton setTitle:@"Log In / Sign up" forState:UIControlStateNormal];
    //[loginButton setBackgroundImage:[UIImage imageNamed:@"login.png"] forState:UIControlStateNormal];
    loginButton.clipsToBounds = YES;
    loginButton.layer.cornerRadius = 5;
    loginButton.layer.borderColor = self.tintColor.CGColor;
    loginButton.layer.borderWidth=2.0f;
    [self addSubview:loginButton];
    [loginButton addTarget:self.delegate action:@selector(loginTapped)  forControlEvents:UIControlEventTouchUpInside];
    
    /*UIButton *signupButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    signupButton.frame = CGRectMake(62, 350, 250, 40);
    //[loginButton setBackgroundColor:[UIColor blueColor]];
    [signupButton setTitle:@"Sign up with Email" forState:UIControlStateNormal];
    [self addSubview:signupButton];*/
    
    UIButton *fbLoginButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    UIImage *fbImage = [UIImage imageNamed:@"facebook.png"];
    CGSize btnSize = CGSizeMake(fbImage.size.width*2, fbImage.size.height*2);
    [fbLoginButton setBackgroundImage:fbImage forState:UIControlStateNormal];
    fbLoginButton.frame = CGRectMake(62, 400, 250, 40);
    [self addSubview:fbLoginButton];
    [fbLoginButton addTarget:self.delegate action:@selector(loginTapped)  forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *twLoginButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    UIImage *twImage = [UIImage imageNamed:@"twitter.png"];
    [twLoginButton setBackgroundImage:twImage forState:UIControlStateNormal];
    twLoginButton.frame = CGRectMake(62, 450, 250, 40);
    [self addSubview:twLoginButton];
    //[twLoginButton addTarget:self.delegate action:@selector(loginTapped)  forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *gLoginButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    UIImage *gImage = [UIImage imageNamed:@"google.png"];
    [gLoginButton setBackgroundImage:gImage forState:UIControlStateNormal];
    gLoginButton.frame = CGRectMake(62, 500, 250, 40);
    [gLoginButton addTarget:self.delegate action:@selector(gloginTapped)  forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:gLoginButton];
    
    //[twLoginButton addTarget:self.delegate action:@selector(loginTapped)  forControlEvents:UIControlEventTouchUpInside];
    
    /*FBLoginView *loginView = [[FBLoginView alloc] initWithReadPermissions:@[@"public_profile", @"email", @"user_friends"]];
    loginView.frame = CGRectOffset(loginView.frame, (self.center.x - (loginView.frame.size.width / 2)), 5);
    loginView.delegate = self;
    [self addSubview:loginView];*/
    
    //_signInButton.frame = CGRectMake(62, 500, 250, 40);
    //[self addSubview:_signInButton];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
