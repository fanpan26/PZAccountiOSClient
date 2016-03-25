//
//  AppDelegate.m
//  记账本
//
//  Created by FanYuepan on 16/2/16.
//  Copyright © 2016年 fyp. All rights reserved.
//

#import "AppDelegate.h"
#import "MSTabBarController.h"
#import "MSUserTool.h"
#import "MSFirstController.h"

#import <RongIMKit/RongIMKit.h>
#import <RongIMLib/RongIMLib.h>
#import <UIKit/UIKit.h>

#import "MSChatConfig.h"
#import "PZNetReachability.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
//   /*即时通讯部分开始*/
//    [[RCIM sharedRCIM] initWithAppKey:kMSChatAppKey];
//    [[MSUserTool sharedMSUserTool] resetLoginIMServer];
//    //推送处理1
//    if([application respondsToSelector:@selector(registerUserNotificationSettings:)]){
//        UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:(UIUserNotificationTypeBadge | UIUserNotificationTypeAlert | UIUserNotificationTypeSound) categories:nil];
//        [application registerUserNotificationSettings:settings];
//    }
//    else{
//        UIRemoteNotificationType myTypes = UIRemoteNotificationTypeBadge |
//        UIRemoteNotificationTypeAlert |
//        UIRemoteNotificationTypeSound;
//        [application registerForRemoteNotificationTypes:myTypes];
//    }
//    
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didReceiveMessageNotification:) name:RCKitDispatchMessageNotification object:nil];
//    [[RCIM sharedRCIM] setConnectionStatusDelegate:self];
   /*即时通讯部分结束*/
    
    [[PZNetReachability sharedInstance] beginNetReach];
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    
    MSCurrentUser *currentUser = [MSUserTool sharedMSUserTool].currentUser;
    if (currentUser == nil || currentUser.userId == 0) {
        //重新登录
        MSFirstController *firstController = [[MSFirstController alloc] init];
        self.window.rootViewController = firstController;
    }else
    {
        self.window.rootViewController = [[MSTabBarController alloc] init];
    }
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    return YES;
}

 -(void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
{
    NSString *token = [[[deviceToken description] stringByReplacingOccurrencesOfString:@"<" withString:@""] stringByReplacingOccurrencesOfString:@">" withString:@""];
    [[RCIMClient sharedRCIMClient] setDeviceToken:token];
}

-(void)onRCIMConnectionStatusChanged:(RCConnectionStatus)status
{
    //账号被别人顶下来了
    if (status == ConnectionStatus_KICKED_OFFLINE_BY_OTHER_CLIENT) {
        NSLog(@"您的账号被别人顶下来了。。。");
        
    }
}

- (void)didReceiveMessageNotification:(NSNotification *)notification {
    [UIApplication sharedApplication].applicationIconBadgeNumber =
    [UIApplication sharedApplication].applicationIconBadgeNumber + 1;
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
