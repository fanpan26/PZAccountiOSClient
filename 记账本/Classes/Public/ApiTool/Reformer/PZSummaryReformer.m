//
//  PZSummaryReformer.m
//  记账本
//
//  Created by FanYuepan on 16/3/24.
//  Copyright © 2016年 fyp. All rights reserved.
//

#import "PZSummaryReformer.h"
#import "PZAllSummary.h"

@implementation PZSummaryReformer

-(PZRequestResult *)reformData:(id)originData fromRequest:(PZBaseRequest *)request
{
    id data;
    if (originData) {
        if ([self isSuccessData:originData]) {
            PZAllSummary *summary = [[PZAllSummary alloc] initWithDictionary:originData[@"data"]];
            data = summary;
        }else{
            data = originData[@"data"];
        }
        PZRequestResult *result = [[PZRequestResult alloc] initWithCode:originData[@"code"] data:data];
        return  result;
    }
    return  nil;
}

@end
