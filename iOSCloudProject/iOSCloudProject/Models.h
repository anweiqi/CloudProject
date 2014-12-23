//
//  Models.h
//  iOSCloudProject
//
//  Created by Jiuyang Zhao on 14/12/20.
//  Copyright (c) 2014年 Weiqi An. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Models : NSObject

@property (nonatomic, strong) NSString *ipAddress;

- (NSData *) getDataFrom:(NSURL *)url;

- (int) postDataTo:(NSURL *)url data:(NSData *)postData;

- (int) putDataTo:(NSURL *)url data:(NSData *)putData;

- (int) deleteData:(NSURL *)url;

@end
