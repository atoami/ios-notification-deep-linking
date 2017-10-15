# [Objective-C] Notification Deep Linking
Code snippets for notification deep linking in Objective-C.

## Register notification
In *AppDelegate.m* file
```
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

    ...

    // Check if app is launched from tapping notification
    if (launchOptions != nil) {
        NSDictionary *dictionary = [launchOptions objectForKey:UIApplicationLaunchOptionsRemoteNotificationKey];
        if (dictionary != nil) {
          ...
        }
    }
    
    return YES;
}
```

## Send notification to the listeners
In *AppDelegate.m* file
```
- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Send notification to the listeners
    [[NSNotificationCenter defaultCenter] postNotificationName:UIApplicationDidReceiveRemoteNotification object:self userInfo:nil];
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    // Get notification details
    ...
    
    // Send notification to the listeners
    [[NSNotificationCenter defaultCenter] postNotificationName:UIApplicationDidReceiveRemoteNotification object:self userInfo:userInfo];
}
```

## Receive notifications in view controllers.
In ViewController.m file
```
- (void)viewDidLoad {
    [super viewDidLoad];
    // Add observer to listen to the notifications
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didReceiveRemoteNotification:) name:UIApplicationDidReceiveRemoteNotification object:nil];
}

-(void)didReceiveRemoteNotification:(NSDictionary *)userInfo {
    if (self.isViewLoaded && self.view.window) {
        // handle the notification
        AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        
        if (appDelegate.notificationData != nil) {
            // do some action by notification data
            ...
        }
    }
}
```
