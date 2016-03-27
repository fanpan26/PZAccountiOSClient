//
//  MSSummaryDetail.m
//  记账本
//
//  Created by FanYuepan on 16/2/20.
//  Copyright © 2016年 fyp. All rights reserved.
//

#import "MSSummaryDetail.h"

@implementation MSSummaryDetail


-(instancetype)initWithMoney:(double)money userid:(NSInteger)userid
{
    if (self = [super init]) {
        _allMoney = money;
        _user = [[MSCurrentUser alloc] initWithUserId:userid];
    }
    return  self;
}
@end
