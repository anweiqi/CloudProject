//
//  GeoCodeModels.h
//  iOSCloudProject
//
//  Created by Jiuyang Zhao on 14/12/23.
//  Copyright (c) 2014年 Weiqi An. All rights reserved.
//

#import "Models.h"

@interface GeoCodeModels : Models <NSURLConnectionDelegate>

@property (nonatomic, strong) NSString *location;

- (void)getLocation:(NSString *)latitude longitude:(NSString *)longitude;

@end
