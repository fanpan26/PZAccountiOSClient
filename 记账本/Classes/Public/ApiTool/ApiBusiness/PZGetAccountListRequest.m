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
    NSUInteger _pageindex;
    NSUInteger _pagesize;
}

@end

@implementation PZGetAccountListRequest


-(instancetype)initWithUserId:(NSUInteger)userid
{
    if (self = [super init]) {
        _pageindex = 1;
        _pagesize = 20;
    }
    return self;
}

-(instancetype)init
{
    return  [self initWithUserId:0];
}

-(NSString *)op
{
    return @"user_cost_list";
}

-(NSUInteger)userid
{
    return 0;
}

-(NSDictionary *)params
{
    return @{
        @"operate_user":@(self.userid),
        @"page_index":@(_pageindex),
        @"page_size":@(_pagesize)
    };
}

-(void)prepareLoadNextPage
{
    _pageindex +=1;
}

-(void)prepareRefreshData
{
    _pageindex = 1;
}



@end
