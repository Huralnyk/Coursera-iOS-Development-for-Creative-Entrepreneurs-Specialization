//
//  AppDelegate.m
//  GrammyPlus
//
//  Created by Alexey Huralnyk on 11/20/15.
//  Copyright © 2015 Alexey Huralnyk. All rights reserved.
//

#import "AppDelegate.h"
#import "NXOAuth2.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    [[NXOAuth2AccountStore sharedStore] setClientID:@"b143aea81acd46e2b4ba1c91108493f1"
                                             secret:@"ead7d60360014f1da18a3f3c55b92d92"
                                   authorizationURL:[NSURL URLWithString:@"https://api.instagram.com/oauth/authorize"]
                                           tokenURL:[NSURL URLWithString:@"https://api.instagram.com/oauth/access_token"]
                                        redirectURL:[NSURL URLWithString:@"grammyplus://authenticated"]
                                     forAccountType:@"Instagram"];
    return YES;
}

- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<NSString *,id> *)options {
    
    NSLog(@"We received a callback");
    return [[NXOAuth2AccountStore sharedStore] handleRedirectURL:url];
}

@end
