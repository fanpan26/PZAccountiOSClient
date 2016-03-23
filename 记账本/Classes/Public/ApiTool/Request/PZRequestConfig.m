//
//  PZRequestConfig.m
//  记账本
//
//  Created by FanYuepan on 16/3/23.
//  Copyright © 2016年 fyp. All rights reserved.
//

#import "PZRequestConfig.h"

@implementation PZRequestConfig

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

@end
