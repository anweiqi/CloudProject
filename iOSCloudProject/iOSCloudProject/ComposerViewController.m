//
//  ComposerViewController.m
//  iOSCloudProject
//
//  Created by Weiqi An on 12/21/14.
//  Copyright (c) 2014 Weiqi An. All rights reserved.
//

#import <CoreLocation/CoreLocation.h>

#import "ComposerViewController.h"
#import "UserSession.h"

@interface ComposerViewController ()

@end

@implementation ComposerViewController

CLLocationManager *locationManager;
NSString *longitude;
NSString *latitude;
NSDictionary* currentUser;

- (void)viewDidLoad {
    [super viewDidLoad];
    _composerView = [[ComposerView alloc] init];
    _composerView.delegate = self;
    self.view = _composerView;
    self.navigationController.title = @"Check In";
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
    currentUser = [UserSession getLoggedinUser];
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
        [_composerView.locationLabel setText:[NSString stringWithFormat:@"%@, %@", latitude, longitude]];
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
    //http://localhost:2015/checkin?email=weiqian@gmail.com&latitude=30&longitude=80&text=helloworld

    NSURLComponents *components = [NSURLComponents componentsWithString:@"http://160.39.221.6:2015/user"];
    NSDictionary *queryDictionary = @{ @"email": currentUser[@"email"], @"latitude": latitude, @"longitude":longitude, @"text": _composerView.checkinText.text};
    NSMutableArray *queryItems = [NSMutableArray array];
    for (NSString *key in queryDictionary) {
        [queryItems addObject:[NSURLQueryItem queryItemWithName:key value:queryDictionary[key]]];
    }
    components.queryItems = queryItems;
    NSURL *url = components.URL;
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setHTTPMethod:@"POST"];
    [request setURL:url];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    
    NSError *error = [[NSError alloc] init];
    NSHTTPURLResponse *responseCode = nil;
    
    NSData *oResponseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&responseCode error:&error];
    
    if([responseCode statusCode] != 200){
        NSLog(@"Error getting %@, HTTP status code %i", url, (int)[responseCode statusCode]);
        NSLog(@"%@", oResponseData);
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                        message:@"Error Connecting to the Server"
                                                       delegate:self
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
    }else{
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Checked In"
                                                        message:@"You have just checked in!"
                                                       delegate:self
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
    }
}

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex {
    if([alertView.title isEqualToString:@"Checked In"]){
        [self exit];
    }
}


- (void) exit{
    [self dismissModalViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
