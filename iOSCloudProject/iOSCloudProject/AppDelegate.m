//
//  AppDelegate.m
//  iOSCloudProject
//
//  Created by Weiqi An on 11/9/14.
//  Copyright (c) 2014 Weiqi An. All rights reserved.
//


#import <GooglePlus/GPPURLHandler.h>
#import <GoogleMaps/GoogleMaps.h>

#import "AppDelegate.h"
#import "LoginViewController.h"
#import "FeedViewController.h"
#import "MapViewController.h"
#import "SettingViewController.h"
#import "FavoriteViewController.h"
#import "FriendListModel.h"
#import "FeedListModel.h"
#import "UserModel.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    //add Google Map Api key
    [GMSServices provideAPIKey:@"AIzaSyDLgFABMiYp_Amm2f4aTvLV-7EdS_iHyWc"];
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    
    // Whenever a person opens the app, check for a cached session
    /*if (FBSession.activeSession.state == FBSessionStateCreatedTokenLoaded) {
        
        // If there's one, just open the session silently, without showing the user the login UI
        [FBSession openActiveSessionWithReadPermissions:@[@"public_profile"]
                                           allowLoginUI:NO
                                      completionHandler:^(FBSession *session, FBSessionState state, NSError *error) {
                                          // Handler for session state changes
                                          // This method will be called EACH time the session state changes,
                                          // also for intermediate states and NOT just when the session open
                                          AppDelegate* appDelegate = [UIApplication sharedApplication].delegate;
                                          [appDelegate sessionStateChanged:session state:state error:error];
                                      }];
    } else {*/
        LoginViewController *loginViewController = [[LoginViewController alloc] init];
        self.window.rootViewController = loginViewController;
    //}
    
    return YES;
}

- (void) showMessage:(NSString *)alertText withTitle:(NSString *) alertTitle
{
    UIAlertView *message = [[UIAlertView alloc] initWithTitle:alertTitle
                                                      message:alertText
                                                     delegate:nil
                                            cancelButtonTitle:@"OK"
                                            otherButtonTitles:nil];
    
    [message show];
}

- (void) userloggedIn{
    FeedViewController *feedViewController = [[FeedViewController alloc] init];
    MapViewController *mapViewController = [[MapViewController alloc] init];
    SettingViewController *settingViewController = [[SettingViewController alloc] init];
    FavoriteViewController *favoriteViewController = [[FavoriteViewController alloc] init];
    
    UINavigationController *feedNavigationController = [[UINavigationController alloc] init];
    [feedNavigationController setViewControllers:[NSArray arrayWithObjects:feedViewController, nil]];
    UINavigationController *mapNavigationController = [[UINavigationController alloc] init];
    [mapNavigationController setViewControllers:[NSArray arrayWithObjects:mapViewController, nil]];
    UINavigationController *settingNavigationController = [[UINavigationController alloc] init];
    [settingNavigationController setViewControllers:[NSArray arrayWithObjects:settingViewController, nil]];
    UINavigationController *favoriteNavigationController = [[UINavigationController alloc] init];
    [favoriteNavigationController setViewControllers:[NSArray arrayWithObjects:favoriteViewController, nil]];
    
    self.tabBarController = [[UITabBarController alloc] init];
    self.tabBarController.viewControllers = [NSArray arrayWithObjects:feedNavigationController, mapNavigationController, favoriteNavigationController, settingNavigationController, nil];
    
    self.window.rootViewController = self.tabBarController;
    
    FriendListModel *friendlist = [[FriendListModel alloc] init];
    friendlist.me = @"jiuyang@gmail.com";
    [friendlist getFriends:friendlist.me];
    
    UserModel *user = [[UserModel alloc] init];
    [user getUser:friendlist.me];
    
    FeedListModel *feedlist = [[FeedListModel alloc] init];
    feedlist.friendList = friendlist;
    feedlist.user = user;
    [feedlist getAllFeeds];
    feedViewController.data = feedlist.feedList;
    mapViewController.data = feedlist.feedList;
    favoriteViewController.data = friendlist.friends;
    favoriteViewController.friendlist = friendlist;
    
}


// This method will handle ALL the session state changes in the app
- (void)sessionStateChanged:(FBSession *)session state:(FBSessionState) state error:(NSError *)error
{
    // If the session was opened successfully
    if (!error && state == FBSessionStateOpen){
        NSLog(@"Session opened");
        // Show the user the logged-in UI
        //[self userLoggedIn];
        
        //_accessTokenData = FBSession.accessTokenData;
        FBAccessTokenData *fbAccessToken = [[FBSession activeSession] accessTokenData];
        NSLog(@"%@",fbAccessToken);
        
        //NSString *post = [NSString stringWithFormat:@"Username=%@&Password=%@",@"username",@"password"];
        
        [self userloggedIn];
        return;
    }
    if (state == FBSessionStateClosed || state == FBSessionStateClosedLoginFailed){
        // If the session is closed
        NSLog(@"Session closed");
        // Show the user the logged-out UI
        //[self userLoggedOut];
    }
    
    // Handle errors
    if (error){
        NSLog(@"Error");
        NSString *alertText;
        NSString *alertTitle;
        // If the error requires people using an app to make an action outside of the app in order to recover
        if ([FBErrorUtility shouldNotifyUserForError:error] == YES){
            alertTitle = @"Something went wrong";
            alertText = [FBErrorUtility userMessageForError:error];
            [self showMessage:alertText withTitle:alertTitle];
        } else {
            
            // If the user cancelled login, do nothing
            if ([FBErrorUtility errorCategoryForError:error] == FBErrorCategoryUserCancelled) {
                NSLog(@"User cancelled login");
                
                // Handle session closures that happen outside of the app
            } else if ([FBErrorUtility errorCategoryForError:error] == FBErrorCategoryAuthenticationReopenSession){
                alertTitle = @"Session Error";
                alertText = @"Your current session is no longer valid. Please log in again.";
                [self showMessage:alertText withTitle:alertTitle];
                
                // Here we will handle all other errors with a generic error message.
                // We recommend you check our Handling Errors guide for more information
                // https://developers.facebook.com/docs/ios/errors/
            } else {
                //Get more error information from the error
                NSDictionary *errorInformation = [[[error.userInfo objectForKey:@"com.facebook.sdk:ParsedJSONResponseKey"] objectForKey:@"body"] objectForKey:@"error"];
                
                // Show the user an error message
                alertTitle = @"Something went wrong";
                alertText = [NSString stringWithFormat:@"Please retry. \n\n If the problem persists contact us and mention this error code: %@", [errorInformation objectForKey:@"message"]];
                [self showMessage:alertText withTitle:alertTitle];
            }
        }
        // Clear this token
        [FBSession.activeSession closeAndClearTokenInformation];
        // Show the user the logged-out UI
        //[self userLoggedOut];
    }
}

// During the Facebook login flow, your app passes control to the Facebook iOS app or Facebook in a mobile browser.
// After authentication, your app will be called back with the session information.
- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation
{
    NSString *urlSTR=[NSString stringWithFormat:@"%@",url];
    NSArray *tempArr=[urlSTR componentsSeparatedByString:@"/"];
    NSString *tempStr=[tempArr objectAtIndex:0];
    if ([tempStr isEqualToString:@"fb366666116837803:"]) {//fb login
        // Note this handler block should be the exact same as the handler passed to any open calls.
        [FBSession.activeSession setStateChangeHandler:
         ^(FBSession *session, FBSessionState state, NSError *error) {
             
             // Retrieve the app delegate
             AppDelegate* appDelegate = [UIApplication sharedApplication].delegate;
             // Call the app delegate's sessionStateChanged:state:error method to handle session state changes
             [appDelegate sessionStateChanged:session state:state error:error];
         }];
        return [FBAppCall handleOpenURL:url sourceApplication:sourceApplication];
    }else {
        //google login
        return [GPPURLHandler handleURL:url
                      sourceApplication:sourceApplication
                             annotation:annotation];
    }

}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Handle the user leaving the app while the Facebook login dialog is being shown
    // For example: when the user presses the iOS "home" button while the login dialog is active
    [FBAppCall handleDidBecomeActive];
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
