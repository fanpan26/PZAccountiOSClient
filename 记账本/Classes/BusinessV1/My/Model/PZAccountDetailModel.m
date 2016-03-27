//
//  PZAccountDetailModel.m
//  记账本
//
//  Created by 范月祥 on 16/3/27.
//  Copyright © 2016年 fyp. All rights reserved.
//

#import "PZAccountDetailModel.h"

@implementation PZAccountDetailModel


+(NSArray *)defaultValues
{
    NSArray *array;
    
    PZAccountDetailModel *all = [[PZAccountDetailModel alloc] init];
    PZAccountDetailModel *last = [[PZAccountDetailModel alloc] init];
    PZAccountDetailModel *salary = [[PZAccountDetailModel alloc] init];
    PZAccountDetailModel *transin = [[PZAccountDetailModel alloc] init];
    PZAccountDetailModel *transout = [[PZAccountDetailModel alloc] init];
    
    array = [NSArray arrayWithObjects:all,last,salary,transin,transout, nil];
    return  array;
}
@end
