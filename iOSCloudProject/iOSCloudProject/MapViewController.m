//
//  MapViewController.m
//  iOSCloudProject
//
//  Created by Weiqi An on 11/13/14.
//  Copyright (c) 2014 Weiqi An. All rights reserved.
//

#import "MapViewController.h"
#import <GoogleMaps/GoogleMaps.h>

@interface MapViewController ()

@property (strong, nonatomic) NSArray *data;

@end

@implementation MapViewController {
    GMSMapView *mapView_;
}

- (id)init {
    self = [super init];
    if (self) {
        self.title = NSLocalizedString(@"Friend Map", @"Map");
        self.tabBarItem.image = [UIImage imageNamed:@"map_marker.png"];
        self.data = @[[[NSDictionary alloc] initWithObjectsAndKeys:
                       @"Weiqi An", @"name",
                       @"weiqi.jpg", @"image",
                       @"facebook_icon.png", @"source",
                       @"5 mins", @"time",
                       @"Hey, look at what I got - with Jennifer Shih", @"content",
                       [NSNumber numberWithDouble:40.807776], @"latitude",
                       [NSNumber numberWithDouble:-73.962547], @"longitude",
                       nil],
                      [[NSDictionary alloc] initWithObjectsAndKeys:
                       @"Nick DeGiacomo", @"name",
                       @"nick.jpg", @"image",
                       @"twitter_icon.png", @"source",
                       @"30 mins", @"time",
                       @"Nice! So happy they got Stephan Hawkin to voice himself in the \"The Theory of Everything!\"", @"content",
                       [NSNumber numberWithDouble:41.807776], @"latitude",
                       [NSNumber numberWithDouble:-74.962547], @"longitude",
                       nil],
                      [[NSDictionary alloc] initWithObjectsAndKeys:
                       @"John Chaiyasarikul", @"name",
                       @"john.jpg", @"image",
                       @"facebook_icon.png", @"source",
                       @"1 hr", @"time",
                       @"Congratulations to my friends and everyone graduating today at Columbia University!!!!", @"content",
                       [NSNumber numberWithDouble:42.807776], @"latitude",
                       [NSNumber numberWithDouble:-75.962547], @"longitude",
                       nil],
                      [[NSDictionary alloc] initWithObjectsAndKeys:
                       @"Jiuyang Zhao", @"name",
                       @"jiuyang.jpg", @"image",
                       @"g+.png", @"source",
                       @"3 hrs", @"time",
                       @"Intel makes it looks like a nuclear weapon unboxing", @"content",
                       [NSNumber numberWithDouble:43.807776], @"latitude",
                       [NSNumber numberWithDouble:-76.962547], @"longitude",
                       nil],
                      [[NSDictionary alloc] initWithObjectsAndKeys:
                       @"Jiuyang Zhao", @"name",
                       @"jiuyang.jpg", @"image",
                       @"g+.png", @"source",
                       @"4 hrs", @"time",
                       @"Missed the first alarm and first class in my first day.", @"content",
                       [NSNumber numberWithDouble:44.807776], @"latitude",
                       [NSNumber numberWithDouble:-77.962547], @"longitude",
                       nil],
                      [[NSDictionary alloc] initWithObjectsAndKeys:
                       @"Hongji Yang", @"name",
                       @"hongji.jpg", @"image",
                       @"twitter_icon.png", @"source",
                       @"1 day", @"time",
                       @"The happiest place in the world!", @"content",
                       [NSNumber numberWithDouble:45.807776], @"latitude",
                       [NSNumber numberWithDouble:-78.962547], @"longitude",
                       nil]];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // Create a GMSCameraPosition that tells the map to display the
    // coordinate -33.86,151.20 at zoom level 6.
    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:40.807776
                                                            longitude:-73.962547
                                                                 zoom:10];
    GMSMapView *mapView = [GMSMapView mapWithFrame:CGRectZero camera:camera];
    
    for (NSDictionary *item in self.data) {
        CLLocationCoordinate2D position = CLLocationCoordinate2DMake([item[@"latitude"] doubleValue], [item[@"longitude"] doubleValue]);
        GMSMarker *marker = [[GMSMarker alloc] init];
        marker.position = position;
        marker.snippet = item[@"content"];
        marker.appearAnimation = kGMSMarkerAnimationPop;
        marker.title = item[@"name"];
        marker.map = mapView;
    }
    
    
    
    self.view = mapView;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
