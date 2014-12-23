//
//  UserSession.m
//  iOSCloudProject
//
//  Created by Weiqi An on 12/22/14.
//  Copyright (c) 2014 Weiqi An. All rights reserved.
//

#import "UserSession.h"

@implementation UserSession

+ (void) storeLoggedinUser:(NSDictionary *)currentUser{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:currentUser[@"$ItemName"] forKey:@"email"];
    [defaults setObject:currentUser[@"password"] forKey:@"password"];
    [defaults setObject:currentUser[@"name"] forKey:@"name"];
    [defaults synchronize];
}

+ (void) removeLoggedinUser{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults removeObjectForKey:@"email"];
    [defaults removeObjectForKey:@"password"];
    [defaults removeObjectForKey:@"name"];
    [defaults synchronize];
}

+ (NSDictionary*) getLoggedinUser{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *email =[defaults objectForKey:@"email"];
    NSLog(@"%@", email);
    NSDictionary * currentUser = @{
                                   @"email":[defaults objectForKey:@"email"],
                                   @"password":[defaults objectForKey:@"password"],
                                   @"name":[defaults objectForKey:@"name"]
                                   };
    return currentUser;
}

//+ (void) updateUserName:(NSString *)name password:{
//    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
//    [defaults setObject:currentUser[@"$ItemName"] forKey:@"email"];
//    [defaults setObject:currentUser[@"password"] forKey:@"password"];
//    [defaults setObject:currentUser[@"name"] forKey:@"name"];
//    [defaults synchronize];
//}

@end
