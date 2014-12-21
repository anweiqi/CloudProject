//
//  FriendListModel.m
//  iOSCloudProject
//
//  Created by Jiuyang Zhao on 14/12/20.
//  Copyright (c) 2014年 Weiqi An. All rights reserved.
//

#import "FriendListModel.h"
#import "FriendModel.h"

@implementation FriendListModel
- (id) init {
    self = [super init];
    self.friends = [NSMutableArray array];
    return self;
}

- (void)getFriends:(NSString *)email {
    NSString* url = [NSString stringWithFormat:@"%@/follow?email=%@", self.ipAddress , email];
    NSData* data = [self getDataFrom: url];
    NSString* friendList = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    NSLog(@"My friends!!!!!: %@", friendList);
    NSError* error;
    //error????
    NSArray* json = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
    for (NSDictionary *item in json) {
        FriendModel *friend = [[FriendModel alloc] init];
        friend.email = item[@"email"];
        friend.name = item[@"name"];
        [self.friends addObject:friend];
    }
}

- (void)addFriends:(NSString *)email {
    NSString* url = [NSString stringWithFormat:@"%@/follow?email=%@&follower=%@", self.ipAddress , self.me, email];
    [self postDataTo:url data: [[NSData alloc] init]];
}

@end
