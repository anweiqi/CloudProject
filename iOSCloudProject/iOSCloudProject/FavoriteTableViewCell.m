//
//  FavoriteTableViewCell.m
//  iOSCloudProject
//
//  Created by Weiqi An on 11/15/14.
//  Copyright (c) 2014 Weiqi An. All rights reserved.
//

#import "FavoriteTableViewCell.h"

@implementation FavoriteTableViewCell

- (id)init {
    self = [super initWithFrame:[[UIScreen mainScreen] bounds]];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        
        _profileImageView = [[UIImageView alloc] initWithFrame:CGRectMake(15.0, 10.0, 50.0, 50.0)];
        //[profileImageView setImage:[UIImage imageNamed:@"weiqi.jpg"]];
        [self addSubview:_profileImageView];
        
        _nameLabel = [[UILabel alloc] init];
        [_nameLabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:12]];
        [_nameLabel setFrame:CGRectMake(85.0, 10.0, 200.0, 25.0)];
        //nameLabel.text = @"Weiqi An";
        [self addSubview:_nameLabel];
        
        _placeLabel = [[UILabel alloc] init];
        [_placeLabel setFont:[UIFont fontWithName:@"HelveticaNeue" size:12]];
        [_placeLabel setFrame:CGRectMake(85.0,35.0, 200.0, 25.0)];
        //placeLabel.text = @"Columbia University / 4 mins ago";
        [self addSubview:_placeLabel];
    }
    return self;
}

- (void) layoutSubviews{
    [super layoutSubviews];
    
    
}

@end
