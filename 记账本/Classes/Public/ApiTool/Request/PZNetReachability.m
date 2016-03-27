//
//  PZNetReachability.m
//  记账本
//
//  Created by FanYuepan on 16/3/23.
//  Copyright © 2016年 fyp. All rights reserved.
//

#import "PZNetReachability.h"
#import "AFNetworking.h"

@interface PZNetReachability()
{
    BOOL _reachable;
}

@end

@implementation PZNetReachability


+(instancetype)sharedInstance
{
    static PZNetReachability *_instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[PZNetReachability alloc] init];
    });
    return _instance;
}

-(instancetype)init
{
    if (self = [super init]) {
        _reachable = YES;
    }
    return self;
}

-(BOOL)netReachable
{
    return _reachable;
}

-(void)beginNetReach
{
    AFNetworkReachabilityManager *mgr = [AFNetworkReachabilityManager sharedManager];
    
    // 2.设置网络状态改变后的处理
    [mgr setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        // 当网络状态改变了, 就会调用这个block
        switch (status) {
            case AFNetworkReachabilityStatusUnknown: // 未知网络
                NSLog(@"未知网络");
                _reachable = YES;
                break;
                
            case AFNetworkReachabilityStatusNotReachable: // 没有网络(断网)
                NSLog(@"没有网络(断网)");
                _reachable = NO;
                break;
                
            case AFNetworkReachabilityStatusReachableViaWWAN: // 手机自带网络
                NSLog(@"手机自带网络");
                _reachable = YES;
                break;
                
            case AFNetworkReachabilityStatusReachableViaWiFi: // WIFI
                NSLog(@"WIFI");
                _reachable = YES;
                break;
        }
    }];
    
    // 3.开始监控
    [mgr startMonitoring];
}
@end
