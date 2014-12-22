//
//  FeedListModel.h
//  iOSCloudProject
//
//  Created by Jiuyang Zhao on 14/12/20.
//  Copyright (c) 2014年 Weiqi An. All rights reserved.
//

#import "Models.h"
#import "FeedModel.h"
#import "FriendListModel.h"
#import <Foundation/Foundation.h>

@interface FeedListModel : Models

@property (nonatomic, strong) NSMutableArray *feedList;
- (void)getFeed:(NSString *)email;
- (void)postFeed:(FeedModel *)feed;
- (void)getAllFeeds;

@property (nonatomic, strong) FriendListModel *friendList;

@end
