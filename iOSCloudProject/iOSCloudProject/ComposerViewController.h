//
//  ComposerViewController.h
//  iOSCloudProject
//
//  Created by Weiqi An on 12/21/14.
//  Copyright (c) 2014 Weiqi An. All rights reserved.
//

#import <CoreLocation/CoreLocation.h>
#import <UIKit/UIKit.h>
#import "ComposerView.h"

@interface ComposerViewController : UIViewController <ComposerDelegate, UIAlertViewDelegate,CLLocationManagerDelegate>

@property ComposerView * composerView;

-(void) locationTapped;

@end
