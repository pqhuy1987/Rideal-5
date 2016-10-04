//
//  AppDelegate.m
//  Rideal
//
//  Created by OSX on 25/08/16.
//  Copyright © 2016 Orem. All rights reserved.
//

#import "AppDelegate.h"
#import "HomeViewController.h"
#import "DEMORootViewController.h"
#import "DataModel.h"
#import "PrefixHeader.pch"
@import GoogleMaps;

@interface AppDelegate ()
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    [GMSServices provideAPIKey:@"AIzaSyDzQEkJiAVu7j2nw-oLcskRZAaSyz7a2e0"];
    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"zoom"];
    
    [[NSUserDefaults standardUserDefaults] setValue:@"All" forKey:@"type"];
    
    if ([application respondsToSelector:@selector(registerUserNotificationSettings:)])
    {
        UIUserNotificationType userNotificationTypes = (UIUserNotificationTypeAlert | UIUserNotificationTypeBadge | UIUserNotificationTypeSound);
        UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:userNotificationTypes categories:nil];
        [application registerUserNotificationSettings:settings];
        [application registerForRemoteNotifications];
    }

    
    
    if ([[NSUserDefaults standardUserDefaults]boolForKey:@"isLogin"])
    {
        [self GetStatusApi];
        _window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        DEMORootViewController * vc = [storyboard instantiateViewControllerWithIdentifier:@"DEMORootViewController"];
        _window.rootViewController = vc ;
        [_window makeKeyAndVisible];

    }

    return YES;
}

#pragma MARK:- GET_STATUS_API

-(void)GetStatusApi
{
    NSString *userID = [[NSUserDefaults standardUserDefaults]valueForKey:@"id"];
    NSDictionary * dict = @{
                            @"userId": userID
                            };
    [[DataModel sharedDataManager] Api:GET_STATUS_API Data:dict withBlock:^(id response, NSError *error)
     {
         if (error !=  nil)
         {
         }
         else
         {
             NSLog(@"%@",response);
             NSDictionary *dict = response;
             [[NSUserDefaults standardUserDefaults] setObject:dict forKey:@"Status_Response"];
         }
     }];
    
}

- (void)application:(UIApplication *)app didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
{
    NSString *token = [[deviceToken description] stringByTrimmingCharactersInSet: [NSCharacterSet characterSetWithCharactersInString:@"<>"]];
    token = [token stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    
    NSLog(@"My device is: %@", token);
//    UIAlertView * alt = [[UIAlertView alloc] initWithTitle:@"Device token" message:token delegate:self cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
//    [alt show];
    [[NSUserDefaults standardUserDefaults] setObject:token forKey:@"MyAppDeviceToken"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    NSLog(@"content---%@", token);
}





- (void)application:(UIApplication *)app didReceiveLocalNotification:(UILocalNotification *)notif
{
   
    NSLog(@"%@",notif);
    
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
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
