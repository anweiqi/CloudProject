//
//  AppDelegate.h
//  iOSCloudProject
//
//  Created by Weiqi An on 11/9/14.
//  Copyright (c) 2014 Weiqi An. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <FacebookSDK/FacebookSDK.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

- (void) sessionStateChanged:(FBSession *)session state:(FBSessionState)state error:(NSError *)error;

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) UITabBarController *tabBarController;

@end

