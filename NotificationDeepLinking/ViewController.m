//
//  ViewController.m
//  NotificationDeepLinking
//
//  Created by David Bala on 10/15/17.
//  Copyright © 2017 David Bala. All rights reserved.
//

#import "ViewController.h"
#import "AppDelegate.h"
#import "Constants.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didReceiveRemoteNotification:) name:UIApplicationDidReceiveRemoteNotification object:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)didReceiveRemoteNotification:(NSDictionary *)userInfo {
    if (self.isViewLoaded && self.view.window) {
        // handle the notification
        AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        
        if (appDelegate.notificationData != nil) {
            // do some action by notification data
        }
    }
}

@end
