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

-(NSString *)op
{
    return @"user_summary";
}

-(NSDictionary *)params
{
    return @{
        @"operate_user":@(_userid),
    };
}



@end
