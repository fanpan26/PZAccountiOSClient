//
//  PZPersonalAccountDetailModel.m
//  记账本
//
//  Created by 范月祥 on 16/3/27.
//  Copyright © 2016年 fyp. All rights reserved.
//

#import "PZPersonalAccountDetailModel.h"

@implementation PZPersonalAccountDetailModel

-(instancetype)initWithDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        self.cost = [dict[@"detail"][@"cost_money"] floatValue];
        self.last = [dict[@"detail"][@"cost_last"] floatValue];
        self.salary = [dict[@"detail"][@"cost_salary"] floatValue];
        self.transin = [dict[@"detail"][@"trans_in"] floatValue];
        self.transout = [dict[@"detail"][@"trans_out"] floatValue];
        self.userid = [dict[@"user"][@"user_id"] integerValue];
        self.username = dict[@"user"][@"user_name"];
        self.userphoto = dict[@"user"][@"user_photo"];
    }
    return self;
}

-(NSArray *)values
{
    return [NSArray arrayWithObjects:@(self.cost),@(self.last),@(self.salary),@(self.transin),@(self.transout), nil];
}

@end
