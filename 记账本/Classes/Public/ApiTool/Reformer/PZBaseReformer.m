//
//  PZBaseReformer.m
//  记账本
//
//  Created by FanYuepan on 16/3/23.
//  Copyright © 2016年 fyp. All rights reserved.
//

#import "PZBaseReformer.h"

@implementation PZBaseReformer

-(PZRequestResult *)reformDataWithRequest:(PZBaseRequest *)request
{
    return [self reformData:request.responseObject fromRequest:request];
}

-(PZRequestResult *)reformData:(id)originData fromRequest:(PZBaseRequest *)request
{
    return  nil;
}


-(BOOL)isSuccessData:(id)originData
{
    if (originData) {
        return [originData[@"code"] isEqualToString:@"ok"];
    }
    return NO;
}

-(NSString *)codeWithData:(id)originData
{
    if (originData) {
        return originData[@"code"];
    }
    return @"err";
}

@end
