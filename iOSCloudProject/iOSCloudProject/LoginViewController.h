//
//  LoginViewController.h
//  iOSCloudProject
//
//  Created by Weiqi An on 11/9/14.
//  Copyright (c) 2014 Weiqi An. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LoginView.h"
#import <GooglePlus/GPPSignIn.h>

@interface LoginViewController : UIViewController <LoginDelegate, GPPSignInDelegate>

- (void) loginTapped;

- (void) myLoginTapped: (NSString *)email;

@property LoginView * loginView;

@end
