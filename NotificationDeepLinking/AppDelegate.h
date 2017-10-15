//
//  AppDelegate.h
//  NotificationDeepLinking
//
//  Created by David Bala on 10/15/17.
//  Copyright © 2017 David Bala. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (nonatomic) BOOL isLaunchedFromNotification;

@property (strong, nonatomic) NSString *notificationMessage;

@property (strong, nonatomic) NSDictionary *notificationData;

@end

