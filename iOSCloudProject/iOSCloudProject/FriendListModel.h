//
//  FriendListModel.h
//  iOSCloudProject
//
//  Created by Jiuyang Zhao on 14/12/20.
//  Copyright (c) 2014年 Weiqi An. All rights reserved.
//

#import "Models.h"
#import <Foundation/Foundation.h>

@interface FriendListModel : Models <NSURLConnectionDelegate>

- (void)getFriends:(NSString *)email;
- (int)addFriends:(NSString *)email;
- (void)deleteFriends:(NSString *)email;

@property (nonatomic, strong) NSMutableArray *friends;
@property (nonatomic, strong) NSMutableDictionary *friendsDictionary;
@property (nonatomic, strong) NSMutableDictionary *friendsColor;
@property (nonatomic, strong) NSMutableDictionary *friendsImage;
@property (nonatomic, strong) NSMutableDictionary *friendsLocation;
@property (nonatomic, strong) NSMutableDictionary *friendsTime;
@property (nonatomic, strong) NSString *me;

@end
