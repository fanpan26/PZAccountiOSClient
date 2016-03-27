//
//  PZRequestConfig.m
//  记账本
//
//  Created by FanYuepan on 16/3/23.
//  Copyright © 2016年 fyp. All rights reserved.
//

#import "PZRequestConfig.h"

@implementation PZRequestConfig

+(instancetype)sharedConfig
{
    static PZRequestConfig *_config;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _config  = [[PZRequestConfig alloc] init];
    });
    return _config;
    
}

-(NSString *)defaultApiDomain
{
    return @"http://imfyp.com";
}

-(NSString *)defaultApiUrl
{
    return  @"/api/account.ashx";
}

-(NSDictionary *)defaultHeaderValue
{
    return  nil;
}

-(NSDictionary *)defaultValidateParams
{
    return @{
        @"token":@"123123"
    };
}

-(BOOL)needValidateResponseObject
{
    return YES;
}

@end
