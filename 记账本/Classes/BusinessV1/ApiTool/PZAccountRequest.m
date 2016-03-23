//
//  PZAccountRequest.m
//  记账本
//
//  Created by FanYuepan on 16/3/23.
//  Copyright © 2016年 fyp. All rights reserved.
//

#import "PZAccountRequest.h"

@implementation PZAccountRequest

-(NSString *)apiUrl
{
    return [NSString stringWithFormat: @"/api/account.ashx?op=%@",self.op];
}

-(PZRequestType)requestType
{
    return PZRequestTypeGet;
}

-(NSString *)op
{
    return @"op";
}

@end
