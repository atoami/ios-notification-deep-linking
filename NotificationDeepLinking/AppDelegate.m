//
//  AppDelegate.m
//  NotificationDeepLinking
//
//  Created by David Bala on 10/15/17.
//  Copyright © 2017 David Bala. All rights reserved.
//

#import "AppDelegate.h"
#import "Constants.h"
#import <UserNotifications/UserNotifications.h>

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Request notification permission
    UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
    [center requestAuthorizationWithOptions:(UNAuthorizationOptionBadge | UNAuthorizationOptionSound | UNAuthorizationOptionAlert)
                          completionHandler:^(BOOL granted, NSError * _Nullable error) {
                              if (!error) {
                                  NSLog(@"request authorization succeeded!");
                              }
                          }];

    // Register remote notification
    [application registerForRemoteNotifications];
    
    // Format notification data
    self.notificationData = nil;
    self.notificationMessage = nil;
    self.isLaunchedFromNotification = false;
    
    // Check if app is launched from tapping notification
    if (launchOptions != nil) {
        NSDictionary *dictionary = [launchOptions objectForKey:UIApplicationLaunchOptionsRemoteNotificationKey];
        if (dictionary != nil) {
            self.notificationMessage = dictionary[@"aps"][@"alert"];
            self.notificationData = dictionary[@"customData"];
            
            if (self.notificationData != nil) {
                self.isLaunchedFromNotification = YES;
            } else {
                self.isLaunchedFromNotification = NO;
            }
        }
    }
    
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    // Send notification to the listeners
    [[NSNotificationCenter defaultCenter] postNotificationName:UIApplicationDidReceiveRemoteNotification object:self userInfo:nil];
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

#pragma mark - Handling Func for Notification Token

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    // Send the deviceToken to backend server.
    NSLog(@"device token = %@", deviceToken);
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    // Get notification details
    self.notificationMessage = userInfo[@"aps"][@"alert"];
    self.notificationData = userInfo[@"customData"];
    
    // Send notification to the listeners
    [[NSNotificationCenter defaultCenter] postNotificationName:UIApplicationDidReceiveRemoteNotification object:self userInfo:userInfo];
}

@end
