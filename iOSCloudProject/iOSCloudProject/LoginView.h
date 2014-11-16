//
//  LoginView.h
//  iOSCloudProject
//
//  Created by Weiqi An on 11/9/14.
//  Copyright (c) 2014 Weiqi An. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol LoginDelegate
@end

@interface LoginView : UIView

@property (weak, nonatomic) id <LoginDelegate> delegate;

@end
