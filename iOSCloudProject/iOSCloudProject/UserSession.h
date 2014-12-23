//
//  UserSession.h
//  iOSCloudProject
//
//  Created by Weiqi An on 12/22/14.
//  Copyright (c) 2014 Weiqi An. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserSession : NSObject

+(void)storeLoggedinUser:(NSDictionary *)currentUser;

+(void)removeLoggedinUser;

+ (NSDictionary*) getLoggedinUser;

@end
