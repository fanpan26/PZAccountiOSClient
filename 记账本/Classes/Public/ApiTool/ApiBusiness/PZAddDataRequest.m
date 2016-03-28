//
//  PZAddDataRequest.m
//  记账本
//
//  Created by FanYuepan on 16/3/28.
//  Copyright © 2016年 fyp. All rights reserved.
//

#import "PZAddDataRequest.h"

@interface PZAddDataRequest()
{
    NSString *_other;
    NSUInteger _category;
    float _money;
    NSUInteger _type;
}

@end

@implementation PZAddDataRequest

-(instancetype)initSalaryTypeWithSalary:(float)money
{
    if (self = [super init]) {
        _money = money;
        _other = @"工资";
        _category  = 0;
        _type = 3;
    }
    return self;
}

-(instancetype)initLastTypeWithLast:(float)money
{
    if (self = [super init]) {
        _money = money;
        _other = @"余额";
        _category  = 0;
        _type = 2;
    }
    return self;
}

-(instancetype)initCostTypeWithCost:(float)money category:(NSUInteger)category other:(NSString *)other
{
    if (self = [super init]) {
        _money = money;
        _other = other;
        _category  = category;
        _type = 1;
    }
    return self;
}

-(PZRequestType)requestType
{
    return PZRequestTypePost;
}

-(NSString *)op
{
    return [NSString stringWithFormat: @"add&token=123123&type=%lu",(unsigned long)_type];
}

-(NSDictionary *)params
{
    return @{
         @"operate_user":@(self.userid),
         @"money":@(_money),
         @"type":@(_type),
         @"category":@(_category),
         @"other":_other
    };
}

@end
