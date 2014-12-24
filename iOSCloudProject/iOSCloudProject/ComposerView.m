//
//  Composer.m
//  iOSCloudProject
//
//  Created by Weiqi An on 12/21/14.
//  Copyright (c) 2014 Weiqi An. All rights reserved.
//

#import "ComposerView.h"

@implementation ComposerView

- (id)init {
    self = [super initWithFrame:[[UIScreen mainScreen] bounds]];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

- (void)layoutSubviews{
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    CGFloat screenWidth = screenRect.size.width;
    CGFloat screenHeight = screenRect.size.height;
    
    _locationButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [_locationButton setFrame:CGRectMake(0, 0, screenWidth, 44)];
    [_locationButton setTitle:@"Get Location" forState:UIControlStateNormal];
    //[_locationButton setBackgroundColor:[UIColor blueColor]];
    [_locationButton addTarget:self.delegate action:@selector(locationTapped) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_locationButton];
    
    _locationLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 44, screenWidth, 44)];
    _locationLabel.textAlignment = NSTextAlignmentCenter;
    _locationLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:13];
    [self addSubview:_locationLabel];
    
    _checkinText = [[UITextView alloc] initWithFrame:CGRectMake(10, 88, screenWidth-20, screenHeight)];
    //_checkinText.textColor = [UIColor blackColor];
    _checkinText.font = [UIFont systemFontOfSize:15.0];
    //[_checkinText setText:@"Say something..."];
    [_checkinText setTextColor:[UIColor lightGrayColor]];
    _checkinText.backgroundColor = [UIColor clearColor];
    _checkinText.autocorrectionType = UITextAutocorrectionTypeYes;
    _checkinText.keyboardType = UIKeyboardTypeDefault;
    //_checkinText.clearButtonMode = UITextFieldViewModeWhileEditing;
    [_checkinText setContentOffset:CGPointZero animated:NO];
    _checkinText.delegate = self;
    [_checkinText becomeFirstResponder];
    [self addSubview:_checkinText];
}

- (BOOL) textViewShouldBeginEditing:(UITextView *)textView
{
    if (textView.textColor == [UIColor lightGrayColor]) {
        textView.text = @"";
        textView.textColor = [UIColor blackColor];
    }
    
    return YES;
}

-(void) textViewDidChange:(UITextView *)textView
{
    if(textView.text.length == 0){
        textView.textColor = [UIColor lightGrayColor];
        textView.text = @"Say something...";
        [textView resignFirstResponder];
    }
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    
    if([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        if(textView.text.length == 0){
            textView.textColor = [UIColor lightGrayColor];
            textView.text = @"Say something...";
            [textView resignFirstResponder];
        }
        return NO;
    }
    
    return YES;
}

@end
