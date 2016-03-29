//
//  PZResponseValidate.m
//  记账本
//
//  Created by FanYuepan on 16/3/24.
//  Copyright © 2016年 fyp. All rights reserved.
//

#import "PZResponseValidate.h"
#import "PZBaseRequest.h"

NSString *const requestSuccessCode = @"ok";
NSString *const requestFailedCode = @"err";
@implementation PZResponseValidate

-(NSDictionary *)validateWithData:(id)responseObject
{
    if (responseObject) {
        //正确结果
        if ([responseObject[@"code"] isEqualToString:requestSuccessCode])  {
            return @{
                @"code":requestSuccessCode,
                @"data":responseObject[@"data"]
            };
        }
        
        if ([responseObject[@"code"] isEqualToString:requestFailedCode]) {
            return @{
                @"code":requestFailedCode,
                @"data":responseObject[@"msg"]
            };
        }
    }
    return nil;
}

@end
