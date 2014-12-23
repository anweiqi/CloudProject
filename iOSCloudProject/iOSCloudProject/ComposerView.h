//
//  Composer.h
//  iOSCloudProject
//
//  Created by Weiqi An on 12/21/14.
//  Copyright (c) 2014 Weiqi An. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ComposerDelegate
@end

@interface ComposerView : UIScrollView <UITextViewDelegate>

@property (weak, nonatomic) id <ComposerDelegate> delegate;

@property UITextView * checkinText;

@property UIButton *locationButton;

@end
