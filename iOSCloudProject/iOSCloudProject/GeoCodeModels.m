//
//  GeoCodeModels.m
//  iOSCloudProject
//
//  Created by Jiuyang Zhao on 14/12/23.
//  Copyright (c) 2014年 Weiqi An. All rights reserved.
//

#import "GeoCodeModels.h"

@implementation GeoCodeModels

- (void)getLocation:(NSString *)latitude longitude:(NSString *)longitude {
    NSString* url = [NSString stringWithFormat:@"http://maps.googleapis.com/maps/api/geocode/json?latlng=%@,%@&sensor=false", latitude , longitude];
    NSData* data = [self getDataFrom: [NSURL URLWithString:url]];
    NSError* error;
    //error????
    NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
    NSLog(@"address dictionary!!!%@", json);
    NSArray *addresses = json[@"results"];
    NSDictionary *address = [addresses objectAtIndex:1];
    NSArray *address_components = address[@"address_components"];
    for(NSDictionary *address_component in address_components) {
        NSArray *types = address_component[@"types"];
        if([types containsObject:@"political"]){
            self.location = address_component[@"short_name"];
            break;
        }
    }
    NSLog(@"This is address!!!%@", self.location);
}

@end
