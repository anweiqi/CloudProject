//
//  ComposerViewController.m
//  iOSCloudProject
//
//  Created by Weiqi An on 12/21/14.
//  Copyright (c) 2014 Weiqi An. All rights reserved.
//

#import <CoreLocation/CoreLocation.h>

#import "ComposerViewController.h"

@interface ComposerViewController ()

@end

@implementation ComposerViewController

CLLocationManager *locationManager;
NSString *longitude;
NSString *latitude;

- (void)viewDidLoad {
    [super viewDidLoad];
    _composerView = [[ComposerView alloc] init];
    _composerView.delegate = self;
    self.view = _composerView;
    UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc]
                                   initWithTitle:@"Cancel"
                                   style:UIBarButtonSystemItemCancel
                                   target:self
                                   action:@selector(exit)];
    self.navigationItem.leftBarButtonItem = cancelButton;
    UIBarButtonItem *postButton = [[UIBarButtonItem alloc]
                                     initWithTitle:@"Post"
                                     style:UIBarButtonSystemItemDone
                                     target:self
                                     action:@selector(post)];
    self.navigationItem.rightBarButtonItem = postButton;
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    NSLog(@"didFailWithError: %@", error);
    UIAlertView *errorAlert = [[UIAlertView alloc]
                               initWithTitle:@"Error" message:@"Failed to Get Your Location" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [errorAlert show];
}

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
    NSLog(@"didUpdateToLocation: %@", newLocation);
    CLLocation *currentLocation = newLocation;
    
    if (currentLocation != nil) {
        longitude = [NSString stringWithFormat:@"%.8f", currentLocation.coordinate.longitude];
        latitude = [NSString stringWithFormat:@"%.8f", currentLocation.coordinate.latitude];
        NSLog(@"%@", longitude);
        NSLog(@"%@", latitude);
        [locationManager stopUpdatingLocation];
    }
}

-(void) locationTapped{
    locationManager = [[CLLocationManager alloc] init];
    locationManager.delegate = self;
    locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    
    locationManager.distanceFilter=kCLDistanceFilterNone;
    [locationManager requestWhenInUseAuthorization];
    [locationManager startMonitoringSignificantLocationChanges];
    
    [locationManager startUpdatingLocation];
}

- (void) post{
    NSString * url = @"http://localhost:2015/checkin?email=weiqian@gmail.com&latitude=40&longitude=85&text=notimeleft";
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setHTTPMethod:@"POST"];
    [request setURL:[NSURL URLWithString:url]];
    
    NSError *error = [[NSError alloc] init];
    NSHTTPURLResponse *responseCode = nil;
    
    NSData *oResponseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&responseCode error:&error];
    
    if([responseCode statusCode] != 200){
        NSLog(@"Error getting %@, HTTP status code %i", url, (int)[responseCode statusCode]);
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                        message:@"Error checkin"
                                                       delegate:self
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
    }else{
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Succeed"
                                                        message:@"Checked in"
                                                       delegate:self
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
    }
    
    
    NSString *result = [[NSString alloc] initWithData:oResponseData encoding:NSUTF8StringEncoding];
    NSDictionary* jsonObject = [NSJSONSerialization JSONObjectWithData:[result dataUsingEncoding:NSUTF8StringEncoding] options:0 error:NULL];
    
    if(jsonObject[@"error"] == 0){
        NSLog(@"%@", @"yesssss");
    }else{
    }
    
    NSLog(@"%@", result);
}

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex {
    // the user clicked OK
    //if (buttonIndex == 0) {}
    [self exit];
}


- (void) exit{
    [self dismissModalViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
