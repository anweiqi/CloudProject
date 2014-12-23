//
//  UserModel.m
//  iOSCloudProject
//
//  Created by Jiuyang Zhao on 14/12/22.
//  Copyright (c) 2014年 Weiqi An. All rights reserved.
//

#import "UserModel.h"

@implementation UserModel
- (id) init {
    self = [super init];
    return self;
}

- (void)getUser:(NSString *)email {
    NSString* url = [NSString stringWithFormat:@"%@/user?email=%@", self.ipAddress , email];
    NSData* data = [self getDataFrom: [NSURL URLWithString:url]];
    NSString* user = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    NSLog(@"My user is!!!!!: %@", user);
    NSError* error;
    //error????
    NSArray *jsonArray = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
    NSDictionary *json = [jsonArray objectAtIndex:0];
    
    /*for (NSDictionary *item in json) {
     FriendModel *friend = [[FriendModel alloc] init];
     friend.email = item[@"email"];
     friend.name = item[@"name"];
     [self.friends addObject:friend];
     }*/
    self.email = email;
    NSLog(@"I am here1");
    self.name = json[@"name"];
    self.password = json[@"password"];
    NSLog(@"I am here2");
    NSString* imageUrl = [NSString stringWithFormat:@"%@/getUserPic/%@.jpg", self.ipAddress , email];
    NSData* imageUrlData = [self getDataFrom: [NSURL URLWithString:imageUrl]];
    NSString* imageS3String = [[NSString alloc] initWithData:imageUrlData encoding:NSUTF8StringEncoding];
    NSURL *imageS3Url = [NSURL URLWithString:imageS3String];
    
    self.imageUrl = imageS3Url;
    
    CGFloat hue = ( arc4random() % 256 / 256.0 );  //  0.0 to 1.0
    CGFloat saturation = ( arc4random() % 128 / 256.0 ) + 0.5;  //  0.5 to 1.0, away from white
    CGFloat brightness = ( arc4random() % 128 / 256.0 ) + 0.5;  //  0.5 to 1.0, away from black
    UIColor *color = [UIColor colorWithHue:hue saturation:saturation brightness:brightness alpha:1];
    self.color = color;
}

- (int)setUser:(NSString *)name password:(NSString *)password {
    
    NSLog(@"%@1", password);
    NSURLComponents *components = [NSURLComponents componentsWithString:[NSString stringWithFormat:@"%@/user", self.ipAddress]];
    NSDictionary *queryDictionary = @{ @"email": self.email, @"password": password, @"name": name};
    NSMutableArray *queryItems = [NSMutableArray array];
    for (NSString *key in queryDictionary) {
        [queryItems addObject:[NSURLQueryItem queryItemWithName:key value:queryDictionary[key]]];
    }
    components.queryItems = queryItems;
    NSURL *url = components.URL;
    NSLog(@"%@2", password);
    int response = [self putDataTo: url data:[[NSData alloc] init]];
    self.name = name;
    NSLog(@"%@3", password);
    return response;
}

@end
