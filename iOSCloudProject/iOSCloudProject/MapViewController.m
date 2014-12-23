//
//  MapViewController.m
//  iOSCloudProject
//
//  Created by Weiqi An on 11/13/14.
//  Copyright (c) 2014 Weiqi An. All rights reserved.
//

#import "MapViewController.h"
#import "FeedModel.h"
#import <GoogleMaps/GoogleMaps.h>

@interface MapViewController ()

@property (strong, nonatomic) NSMutableArray *markers;

@end

@implementation MapViewController {
    GMSMapView *mapView_;
}

- (id)init {
    self = [super init];
    if (self) {
        self.title = NSLocalizedString(@"Friend Map", @"Map");
        self.tabBarItem.image = [UIImage imageNamed:@"map_marker.png"];
        self.markers = [NSMutableArray array];
        
        UIBarButtonItem *addButton = [[UIBarButtonItem alloc]
                                      initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh
                                      target:self action:@selector(getLatestFeeds)];
        self.navigationItem.rightBarButtonItem = addButton;
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
    
    for (FeedModel *feed in self.data) {
        CLLocationCoordinate2D position = CLLocationCoordinate2DMake(feed.latitude, feed.longitude);
        GMSMarker *marker = [[GMSMarker alloc] init];
        marker.position = position;
        marker.snippet = feed.content;
        marker.appearAnimation = kGMSMarkerAnimationPop;
        marker.title = feed.name;
        marker.map = mapView;
        marker.icon = [GMSMarker markerImageWithColor:feed.color];
        [self.markers addObject:marker];
    }
    
    
    
    self.view = mapView;
    
}

- (void)getLatestFeeds
{
    
    [self.feedList getAllFeeds];
    self.data = self.feedList.feedList;
    // As this block of code is run in a background thread, we need to ensure the GUI
    // update is executed in the main thread
    [self performSelectorOnMainThread:@selector(reloadData) withObject:nil waitUntilDone:NO];
    
}

- (void)reloadData
{
    
    for (GMSMarker *marker in self.markers) {
        marker.map = nil;
    }
    
    [self.markers removeAllObjects];
    
    for (FeedModel *feed in self.data) {
        CLLocationCoordinate2D position = CLLocationCoordinate2DMake(feed.latitude, feed.longitude);
        GMSMarker *marker = [[GMSMarker alloc] init];
        marker.position = position;
        marker.snippet = feed.content;
        marker.appearAnimation = kGMSMarkerAnimationPop;
        marker.title = feed.name;
        marker.map = self.view;
        marker.icon = [GMSMarker markerImageWithColor:feed.color];
        [self.markers addObject:marker];
    }
    
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
