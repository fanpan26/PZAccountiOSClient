//
//  PZPersonalSummaryRequest.m
//  记账本
//
//  Created by 范月祥 on 16/3/27.
//  Copyright © 2016年 fyp. All rights reserved.
//

#import "PZPersonalSummaryRequest.h"

@implementation PZPersonalSummaryRequest


-(NSString *)op
{
    return @"user_summary";
}

-(NSDictionary *)params
{
    return @{
        @"operate_user":@(self.userid)
    };
}
@end
