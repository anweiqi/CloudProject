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
    self.friendsDictionary = [[NSMutableDictionary alloc] init];
    self.friendsColor = [[NSMutableDictionary alloc] init];
    self.friendsImage = [[NSMutableDictionary alloc] init];
    self.friendsLocation = [[NSMutableDictionary alloc] init];
    self.friendsTime = [[NSMutableDictionary alloc] init];
    return self;
}

- (void)getFriends:(NSString *)email {
    self.friends = [NSMutableArray array];
    NSString* url = [NSString stringWithFormat:@"%@/follow?email=%@", self.ipAddress , email];
    NSData* data = [self getDataFrom: [NSURL URLWithString:url]];
    NSString* friendList = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    NSLog(@"My friends!!!!!: %@", friendList);
    NSError* error;
    //error????
    NSArray* json = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
    for (NSDictionary *item in json) {
        FriendModel *friend = [[FriendModel alloc] init];
        friend.email = item[@"$ItemName"];
        friend.name = item[@"name"];
        [self.friends addObject:friend];
        [self.friendsDictionary setValue:friend.name forKey:friend.email];
        CGFloat hue = ( arc4random() % 256 / 256.0 );  //  0.0 to 1.0
        CGFloat saturation = ( arc4random() % 128 / 256.0 ) + 0.5;  //  0.5 to 1.0, away from white
        CGFloat brightness = ( arc4random() % 128 / 256.0 ) + 0.5;  //  0.5 to 1.0, away from black
        UIColor *color = [UIColor colorWithHue:hue saturation:saturation brightness:brightness alpha:1];
        [self.friendsColor setValue:color forKey:friend.email];
        NSString* imageUrl = [NSString stringWithFormat:@"%@/getUserPic/%@.jpg", self.ipAddress , friend.email];
        NSData* imageUrlData = [self getDataFrom: [NSURL URLWithString:imageUrl]];
        NSString* imageS3String = [[NSString alloc] initWithData:imageUrlData encoding:NSUTF8StringEncoding];
        NSURL *imageS3Url = [NSURL URLWithString:imageS3String];
        friend.image = imageS3Url;
        [self.friendsImage setValue:imageS3Url forKey:friend.email];
    }
    
}

- (int)addFriends:(NSString *)email {
    NSString* url = [NSString stringWithFormat:@"%@/follow?email=%@&follower=%@", self.ipAddress , self.me, email];
    int response = [self postDataTo:[NSURL URLWithString:url] data: [[NSData alloc] init]];
    [self getFriends:self.me];
    return response;
}

- (void)deleteFriends:(NSString *)email {
    NSString* url = [NSString stringWithFormat:@"%@/follow?email=%@&follower=%@", self.ipAddress , self.me, email];
    [self deleteData:[NSURL URLWithString:url]];
}

@end
