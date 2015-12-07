//
//  AppDelegate.m
//  ParsePushyApp
//
//  Created by Alexey Huralnyk on 12/2/15.
//  Copyright © 2015 Alexey Huralnyk. All rights reserved.
//

#import "AppDelegate.h"
#import "Parse/Parse.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    NSDictionary *remoteNotification = launchOptions[UIApplicationLaunchOptionsRemoteNotificationKey];
    
    if (remoteNotification) {
        NSString *remoteMessage = remoteNotification[@"aps"][@"alert"];
        UIAlertController *ac = [UIAlertController alertControllerWithTitle:@"Received on launch" message:remoteMessage preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *aa = [UIAlertAction actionWithTitle:@"Okay" style:UIAlertActionStyleDefault handler:nil];
        [ac addAction:aa];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [application.keyWindow.rootViewController presentViewController:ac animated:YES completion:nil];
        });
    }
    
    // Configure Parse
    [Parse setApplicationId:@"H3Ub3TpPOcqNbRfecCGWDeFrg0oJBN5YepVToDEG" clientKey:@"MLEVCMUOmULAebkQXFrztJXe7KXt2VpncHzbzKJA"];
    
    UIUserNotificationType types = UIUserNotificationTypeAlert | UIUserNotificationTypeBadge | UIUserNotificationTypeSound;
    UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:types categories:nil];
    [application registerUserNotificationSettings:settings];
    [application registerForRemoteNotifications];
    
    return YES;
}

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    PFInstallation *currentInstallation = [PFInstallation currentInstallation];
    [currentInstallation setDeviceTokenFromData:deviceToken];
    [currentInstallation saveInBackground];
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)remoteNotification {
    NSString *remoteMessage = remoteNotification[@"aps"][@"alert"];
    UIAlertController *ac = [UIAlertController alertControllerWithTitle:@"Received while running" message:remoteMessage preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *aa = [UIAlertAction actionWithTitle:@"Okay" style:UIAlertActionStyleDefault handler:nil];
    [ac addAction:aa];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [application.keyWindow.rootViewController presentViewController:ac animated:YES completion:nil];
    });
}
@end
