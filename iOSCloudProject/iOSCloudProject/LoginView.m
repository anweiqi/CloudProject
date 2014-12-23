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
        
    }
    return self;
}

- (void) layoutSubviews{
    
    UIImageView *logo = [[UIImageView alloc] initWithFrame:CGRectMake(62, 100, 250, 70)];
    [logo setImage:[UIImage imageNamed:@"logo.png"]];
    [self addSubview:logo];
    
    _emailTextField = [[UITextField alloc] initWithFrame:CGRectMake(62, 200, 250, 40)];
    _emailTextField.borderStyle = UITextBorderStyleRoundedRect;
    _emailTextField.textColor = [UIColor blackColor];
    _emailTextField.font = [UIFont systemFontOfSize:15.0];
    _emailTextField.placeholder = @"Email";
    _emailTextField.backgroundColor = [UIColor clearColor];
    _emailTextField.autocorrectionType = UITextAutocorrectionTypeYes;
    _emailTextField.delegate = self.delegate;
    [self addSubview:_emailTextField];
    
    _passwordTextField = [[UITextField alloc] initWithFrame:CGRectMake(62, 250, 250, 40)];
    _passwordTextField.borderStyle = UITextBorderStyleRoundedRect;
    _passwordTextField.textColor = [UIColor blackColor];
    _passwordTextField.font = [UIFont systemFontOfSize:15.0];
    _passwordTextField.placeholder = @"Password";
    _passwordTextField.backgroundColor = [UIColor clearColor];
    _passwordTextField.secureTextEntry = YES;
    _passwordTextField.delegate = self.delegate;
    [self addSubview:_passwordTextField];
    
    UIButton *loginButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    loginButton.frame = CGRectMake(62, 300, 250, 40);
    //[loginButton setBackgroundColor:[UIColor blueColor]];
    [loginButton setTitle:@"Log In" forState:UIControlStateNormal];
    //[loginButton setBackgroundImage:[UIImage imageNamed:@"login.png"] forState:UIControlStateNormal];
    loginButton.clipsToBounds = YES;
    loginButton.layer.cornerRadius = 5;
    loginButton.layer.borderColor = self.tintColor.CGColor;
    loginButton.layer.borderWidth=2.0f;
    [loginButton addTarget:self.delegate action:@selector(myLoginTapped) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:loginButton];
    
    UIButton *signupButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    signupButton.frame = CGRectMake(62, 350, 250, 40);
    //[loginButton setBackgroundColor:[UIColor blueColor]];
    [signupButton.titleLabel setFont:[UIFont boldSystemFontOfSize:13.0f]];
    [signupButton setTitle:@"Sign Up" forState:UIControlStateNormal];
    [signupButton addTarget:self.delegate action:@selector(mySignUpTapped) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:signupButton];
    
    /*UIButton *signupButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    signupButton.frame = CGRectMake(62, 350, 250, 40);
    //[loginButton setBackgroundColor:[UIColor blueColor]];
    [signupButton setTitle:@"Sign up with Email" forState:UIControlStateNormal];
    [self addSubview:signupButton];*/
    
    UIButton *fbLoginButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    UIImage *fbImage = [UIImage imageNamed:@"facebook.png"];
    CGSize btnSize = CGSizeMake(fbImage.size.width*2, fbImage.size.height*2);
    [fbLoginButton setBackgroundImage:fbImage forState:UIControlStateNormal];
    fbLoginButton.frame = CGRectMake(62, 420, 250, 40);
    [self addSubview:fbLoginButton];
    [fbLoginButton addTarget:self.delegate action:@selector(loginTapped)  forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *gLoginButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    UIImage *gImage = [UIImage imageNamed:@"google.png"];
    [gLoginButton setBackgroundImage:gImage forState:UIControlStateNormal];
    gLoginButton.frame = CGRectMake(62, 470, 250, 40);
    [gLoginButton addTarget:self.delegate action:@selector(gloginTapped)  forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:gLoginButton];
}

@end
