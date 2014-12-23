//
//  SettingTableViewCell.m
//  iOSCloudProject
//
//  Created by Jiuyang Zhao on 14/11/22.
//  Copyright (c) 2014年 Weiqi An. All rights reserved.
//

#import "SettingTableViewCell.h"

@implementation SettingTableViewCell

- (id)init {
    self = [super initWithFrame:[[UIScreen mainScreen] bounds]];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        
        _field = [[UILabel alloc] init];
        [self addSubview:_field];
        
        _content = [[UITextView alloc] init];
        [self addSubview:_content];
    }
    return self;
}

- (void) layoutSubviews{
    [super layoutSubviews];
    
    [_field setFont:[UIFont fontWithName:@"HelveticaNeue" size:20]];
    [_field setFrame:CGRectMake(20.0, 00.0, 100, 40)];
    [_content setFont:[UIFont fontWithName:@"HelveticaNeue" size:20]];
    [_content setFrame:CGRectMake(120.0,00.0, 250, 40)];
    
}

@end
