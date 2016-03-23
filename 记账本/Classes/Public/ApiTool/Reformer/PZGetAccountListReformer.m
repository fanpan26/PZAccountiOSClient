//
//  PZGetAccountListReformer.m
//  记账本
//
//  Created by FanYuepan on 16/3/23.
//  Copyright © 2016年 fyp. All rights reserved.
//

#import "PZGetAccountListReformer.h"
#import "PZGetAccountListRequest.h"

@implementation PZGetAccountListReformer

-(NSDictionary *)reformDataWithManager:(PZBaseRequest *)request
{
    return [self reformData:request.responseObject fromRequest:request];
}


- (NSDictionary *)reformData:(id)originData fromRequest:(PZBaseRequest *)request
{
    if ([originData[@"code"] isEqualToString:@"err"]) {
        return nil;
    }
    NSDictionary *resultData = nil;
    if ([request isKindOfClass:[PZGetAccountListRequest class]]) {
        resultData = @{
            @"userid":originData[@"data"][@"user"][@"user_id"],
            @"username":originData[@"data"][@"user"][@"user_name"],
            @"userphoto":originData[@"data"][@"user"][@"user_photo"]
        };
    }
    return resultData;
}

@end
