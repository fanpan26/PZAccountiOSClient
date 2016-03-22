//
//  MSUserSummary.m
//  记账本
//
//  Created by FanYuepan on 16/2/20.
//  Copyright © 2016年 fyp. All rights reserved.
//

#import "MSSummaryAll.h"

@implementation MSSummaryAll

-(instancetype)init
{

    if (self = [super init]) {
        _allDetail = [[MSSummaryDetail alloc] initWithMoney:0.0f userid:0];
        _userDetail1 =  [[MSSummaryDetail alloc] initWithMoney:0.0f userid:1];
        _userDetail2 =  [[MSSummaryDetail alloc] initWithMoney:0.0f userid:2];
        _userDetail3 =  [[MSSummaryDetail alloc] initWithMoney:0.0f userid:3];

    }
    return  self;
}

@end
