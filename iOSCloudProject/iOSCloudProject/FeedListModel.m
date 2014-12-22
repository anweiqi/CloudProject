//
//  FeedListModel.m
//  iOSCloudProject
//
//  Created by Jiuyang Zhao on 14/12/20.
//  Copyright (c) 2014年 Weiqi An. All rights reserved.
//

#import "FeedListModel.h"
#import "FriendModel.h"

@implementation FeedListModel
- (id) init {
    self = [super init];
    self.feedList = [NSMutableArray array];
    return self;
}

- (void)getFeed:(NSString *)email {
    
    NSString* textUrl = [NSString stringWithFormat:@"%@/checkin?email=%@", self.ipAddress , email];
    NSData* textData = [self getDataFrom: textUrl];
    NSError* error;
//error????
    NSArray* json = [NSJSONSerialization JSONObjectWithData:textData options:kNilOptions error:&error];
    
    for (NSDictionary *item in json) {
        FeedModel *feed = [[FeedModel alloc] init];
        feed.email = email;
        feed.name = self.friendList.friendsDictionary[item[@"email"]];
        feed.color = self.friendList.friendsColor[item[@"email"]];
        feed.imageUrl = self.friendList.friendsImage[item[@"email"]];
        feed.locationliteral = @"Here";
        NSLog(@"THis is color!!!%@", [feed.color description]);
        feed.time = item[@"time"];
        NSTimeInterval secondsSinceUnixEpoch = [[NSDate date]timeIntervalSince1970];
        long currentTime = secondsSinceUnixEpoch;
        NSLog(@"Currenttime is %li!!!!!!!", currentTime);
        long feedTime = [item[@"time"] longLongValue]/1000;
        NSLog(@"Feedtime is %li!!!!!!!", feedTime);
        long time = currentTime - feedTime;
        NSLog(@"time is %li!!!!!!!", time);
        if (time < 60) {
            feed.timeliteral = [NSString stringWithFormat:@"%li sec", time];
        } else {
            time = time / 60;
            if (time < 60) {
                feed.timeliteral = [NSString stringWithFormat:@"%li min", time];
            } else {
                time = time / 60;
                if(time < 24) {
                    feed.timeliteral = [NSString stringWithFormat:@"%li hr", time];
                } else {
                    time = time / 24;
                    feed.timeliteral = [NSString stringWithFormat:@"%li days", time];
                }
            }
        }
        feed.content = item[@"text"];
        feed.latitude = [item[@"latitude"] doubleValue];
        feed.longitude = [item[@"longitude"] doubleValue];
        [self.feedList addObject:feed];
    }
    
}

- (void)getMyFeed:(NSString *)email {
    
    NSString* textUrl = [NSString stringWithFormat:@"%@/checkin?email=%@", self.ipAddress , email];
    NSData* textData = [self getDataFrom: textUrl];
    NSError* error;
    //error????
    NSArray* json = [NSJSONSerialization JSONObjectWithData:textData options:kNilOptions error:&error];
    
    for (NSDictionary *item in json) {
        FeedModel *feed = [[FeedModel alloc] init];
        feed.email = email;
        feed.name = self.user.name;
        feed.color = self.user.color;
        feed.imageUrl = self.user.imageUrl;
        feed.locationliteral = @"Here";
        NSLog(@"THis is color!!!%@", [feed.color description]);
        feed.time = item[@"time"];
        NSTimeInterval secondsSinceUnixEpoch = [[NSDate date]timeIntervalSince1970];
        long currentTime = secondsSinceUnixEpoch;
        NSLog(@"Currenttime is %li!!!!!!!", currentTime);
        long feedTime = [item[@"time"] longLongValue]/1000;
        NSLog(@"Feedtime is %li!!!!!!!", feedTime);
        long time = currentTime - feedTime;
        NSLog(@"time is %li!!!!!!!", time);
        if (time < 60) {
            feed.timeliteral = [NSString stringWithFormat:@"%li sec", time];
        } else {
            time = time / 60;
            if (time < 60) {
                feed.timeliteral = [NSString stringWithFormat:@"%li min", time];
            } else {
                time = time / 60;
                if(time < 24) {
                    feed.timeliteral = [NSString stringWithFormat:@"%li hr", time];
                } else {
                    time = time / 24;
                    feed.timeliteral = [NSString stringWithFormat:@"%li days", time];
                }
            }
        }
        feed.content = item[@"text"];
        feed.latitude = [item[@"latitude"] doubleValue];
        feed.longitude = [item[@"longitude"] doubleValue];
        [self.feedList addObject:feed];
    }
    
}

- (void)getAllFeeds {
    for (FriendModel *friend in self.friendList.friends) {
        [self getFeed:friend.email];
    }
    
    [self getMyFeed:self.friendList.me];

    NSMutableArray *sortedArray = [[self.feedList sortedArrayUsingComparator:^NSComparisonResult(FeedModel *f1, FeedModel *f2){
        
        return [f2.time compare: f1.time];
        
    }] mutableCopy];
    self.feedList = sortedArray;
    
    for (FeedModel *feed in self.feedList) {
        NSString *location = [self.friendList.friendsLocation objectForKey:feed.email];
        if (location == nil) {
            [self.friendList.friendsLocation setValue:feed.locationliteral forKey:feed.email];
            [self.friendList.friendsTime setValue:feed.timeliteral forKey:feed.email];
        }
    }
    
}

- (void)postFeed:(FeedModel *)feed {
    
}


@end
