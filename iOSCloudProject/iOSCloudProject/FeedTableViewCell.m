//
//  FeedTableViewCell.m
//  iOSCloudProject
//
//  Created by Weiqi An on 11/15/14.
//  Copyright (c) 2014 Weiqi An. All rights reserved.
//

#import "FeedTableViewCell.h"

@implementation FeedTableViewCell

- (id)init {
    self = [super initWithFrame:[[UIScreen mainScreen] bounds]];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        
        _profileImageView = [[UIImageView alloc] initWithFrame:CGRectMake(15.0, 10.0, 30.0, 30.0)];
        //[_profileImageView setImage:[UIImage imageNamed:@"Icon.png"]];
        [self addSubview:_profileImageView];
        
        _nameLabel = [[UILabel alloc] init];
        [self addSubview:_nameLabel];
        
        _timeLabel = [[UILabel alloc] init];
        [self addSubview:_timeLabel];
        
        _content = [[UITextView alloc] init];
        [self addSubview:_content];
        
    }
    return self;
}

- (void) layoutSubviews{
    [super layoutSubviews];
    
    [_nameLabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:13]];
    [_nameLabel setFrame:CGRectMake(80.0, 13.0, 210.0, 24.0)];
    //_nameLabel.text = @"Weiqi An";
    
    [_timeLabel setFont:[UIFont fontWithName:@"HelveticaNeue" size:13]];
    [_timeLabel setFrame:CGRectMake(300.0, 13.0, 60.0, 24.0)];
    //_timeLabel.text = @"4 mins";
    _timeLabel.textAlignment = NSTextAlignmentRight;
    
    //[_content setText:@"There's just no way to describe this moment of my lifetime. It is so extraordinary to be in In& Out and watch CQ eat two double-doubles in 5 mins. I enjoy junk food. But it was way"];
    [_content setFont:[UIFont fontWithName:@"HelveticaNeue" size:13]];
    //[_content setFrame:CGRectMake(15.0, 40.0, 345.0, 60.0)];
    CGFloat fixedWidth = 345;
    CGSize newSize = [_content sizeThatFits:CGSizeMake(fixedWidth, MAXFLOAT)];
    [_content setFrame:CGRectMake(15.0, 40.0, 345.0, newSize.height)];
    _content.editable = NO;
    /*CGRect newFrame = _content.frame;
     newFrame.size = CGSizeMake(fmaxf(newSize.width, fixedWidth), newSize.height);
     _content.frame = newFrame;*/
    
    // NSLog(@"%lu",(unsigned long)content.text.length);
}

@end
