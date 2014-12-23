//
//  UserModel.h
//  iOSCloudProject
//
//  Created by Jiuyang Zhao on 14/12/22.
//  Copyright (c) 2014年 Weiqi An. All rights reserved.
//

#import "Models.h"
#import "FriendListModel.h"
#import <UIKit/UIKit.h>

@interface UserModel : Models <NSURLConnectionDelegate>

- (void)getUser:(NSString *)email;
- (int)setUser:(NSString *)name password:(NSString *)password;

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *email;
@property (nonatomic, strong) NSString *password;
@property (nonatomic, strong) NSURL *imageUrl;
@property (nonatomic, strong) UIColor *color;

@end
