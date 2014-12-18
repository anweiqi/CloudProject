//
//  LoginView.h
//  iOSCloudProject
//
//  Created by Weiqi An on 11/9/14.
//  Copyright (c) 2014 Weiqi An. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <GooglePlus/GPPSignIn.h>

@protocol LoginDelegate
@end

@class GPPSignInButton;

@interface LoginView : UIView

@property (weak, nonatomic) id <LoginDelegate> delegate;

@property (retain, nonatomic) GPPSignInButton *signInButton;

@end
