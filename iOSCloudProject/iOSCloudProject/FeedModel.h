//
//  FeedViewModel.h
//  iOSCloudProject
//
//  Created by Jiuyang Zhao on 14/12/20.
//  Copyright (c) 2014年 Weiqi An. All rights reserved.
//

#import "Models.h"
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface FeedModel : Models

@property (nonatomic, strong) NSString *email;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) UIColor *color;
@property (nonatomic, strong) UIImage *image;
@property (nonatomic, strong) NSString *time;
@property (nonatomic, strong) NSString *timeliteral;
@property (nonatomic, strong) NSString *locationliteral;
@property (nonatomic, strong) NSString *content;
@property (nonatomic, strong) NSURL *imageUrl;
@property (nonatomic) double latitude;
@property (nonatomic) double longitude;

@end
