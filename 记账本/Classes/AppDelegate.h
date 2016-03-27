//
//  AppDelegate.h
//  记账本
//
//  Created by FanYuepan on 16/2/16.
//  Copyright © 2016年 fyp. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <RongIMKit/RongIMKit.h>
#import <RongIMLib/RongIMLib.h>

/*遵守融云链接状态监听代理*/
@interface AppDelegate : UIResponder <UIApplicationDelegate,RCIMConnectionStatusDelegate>

@property (strong, nonatomic) UIWindow *window;


@end

