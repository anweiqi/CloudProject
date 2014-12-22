//
//  FriendListModel.m
//  iOSCloudProject
//
//  Created by Jiuyang Zhao on 14/12/20.
//  Copyright (c) 2014年 Weiqi An. All rights reserved.
//

#import "FriendListModel.h"
#import "FriendModel.h"
#import <UIKit/UIKit.h>

@implementation FriendListModel
- (id) init {
    self = [super init];
    self.friends = [NSMutableArray array];
    self.friendsDictionary = [[NSMutableDictionary alloc] init];
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
    /*for (NSDictionary *item in json) {
        FriendModel *friend = [[FriendModel alloc] init];
        friend.email = item[@"email"];
        friend.name = item[@"name"];
        [self.friends addObject:friend];
    }*/
    FriendModel *friend = [[FriendModel alloc] init];
    friend.email = @"nick@gmail.com";
    friend.name = @"nick";
    [self.friends addObject:friend];
    FriendModel *friend2 = [[FriendModel alloc] init];
    friend2.email = @"john@gmail.com";
    friend2.name = @"John";
    [self.friends addObject:friend2];
    
    //build dictionary
    for (FriendModel *friend in self.friends) {
        [self.friendsDictionary setValue:friend.name forKey:friend.email];
    }
    for (FriendModel *friend in self.friends) {
        CGFloat hue = ( arc4random() % 256 / 256.0 );  //  0.0 to 1.0
        CGFloat saturation = ( arc4random() % 128 / 256.0 ) + 0.5;  //  0.5 to 1.0, away from white
        CGFloat brightness = ( arc4random() % 128 / 256.0 ) + 0.5;  //  0.5 to 1.0, away from black
        UIColor *color = [UIColor colorWithHue:hue saturation:saturation brightness:brightness alpha:1];
        [self.friendsColor setValue:color forKey:friend.email];
    }
}

- (void)addFriends:(NSString *)email {
    NSString* url = [NSString stringWithFormat:@"%@/follow?email=%@&follower=%@", self.ipAddress , self.me, email];
    [self postDataTo:url data: [[NSData alloc] init]];
}

@end
