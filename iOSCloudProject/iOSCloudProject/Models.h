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

- (NSData *) getDataFrom:(NSString *)url;

- (void) postDataTo:(NSString *)url data:(NSData *)postData;

- (void) deleteData:(NSString *)url;

@end
