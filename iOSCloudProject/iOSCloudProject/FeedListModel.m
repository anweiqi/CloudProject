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
    NSString* imageUrl = [NSString stringWithFormat:@"%@/getUserPic/%@.jpg", self.ipAddress , email];
    NSData* textData = [self getDataFrom: textUrl];
    NSData* imageUrlData = [self getDataFrom: imageUrl];
    NSString* imageS3String = [[NSString alloc] initWithData:imageUrlData encoding:NSUTF8StringEncoding];
    NSURL *imageS3Url = [NSURL URLWithString:imageS3String];
    NSError* error;
//error????
    NSArray* json = [NSJSONSerialization JSONObjectWithData:textData options:kNilOptions error:&error];
    
    for (NSDictionary *item in json) {
        FeedModel *feed = [[FeedModel alloc] init];
        feed.name = @"weiqi";//item[@"name"];
        feed.time = item[@"time"];
        feed.content = item[@"text"];
        feed.imageUrl = imageS3Url;
        [self.feedList addObject:feed];
    }
    
}

- (void)getAllFeeds {
    for (FriendModel *friend in self.friendList.friends) {
        [self getFeed:friend.email];
    }

    NSMutableArray *sortedArray = [[self.feedList sortedArrayUsingComparator:^NSComparisonResult(FeedModel *f1, FeedModel *f2){
        
        return [f1.time compare: f2.time];
        
    }] mutableCopy];
    self.feedList = sortedArray;
    
}

- (void)postFeed:(FeedModel *)feed {
    
}


@end
