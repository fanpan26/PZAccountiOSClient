//
//  PZUserSummaryRequest.m
//  记账本
//
//  Created by FanYuepan on 16/3/24.
//  Copyright © 2016年 fyp. All rights reserved.
//

#import "PZUserSummaryRequest.h"

@implementation PZUserSummaryRequest


-(PZRequestType)requestType
{
    return  PZRequestTypeGet;
}

-(NSString *)op
{
    return @"all_summary";
}
@end
