//
//  PZGetAccountListRequest.m
//  记账本
//
//  Created by FanYuepan on 16/3/23.
//  Copyright © 2016年 fyp. All rights reserved.
//

#import "PZGetAccountListRequest.h"

@interface PZGetAccountListRequest()
{
    NSUInteger _userid;
}

@end

@implementation PZGetAccountListRequest


-(instancetype)initWithUserId:(NSUInteger)userid
{
    if (self = [super init]) {
        _userid = userid;
    }
    return self;
}

-(NSString *)apiUrl
{
    return [NSString stringWithFormat: @"/api/account.ashx?op=%@",self.op];
}

-(NSString *)op
{
    return @"user_summary";
}

-(PZRequestType)requestType
{
    return PZRequestTypeGet;
}

-(NSDictionary *)params
{
    return @{
        @"operate_user":@(_userid),
        @"token":@"123123"
    };
}



@end
