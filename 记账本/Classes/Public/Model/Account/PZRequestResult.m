//
//  PZRequestResult.m
//  记账本
//
//  Created by FanYuepan on 16/3/24.
//  Copyright © 2016年 fyp. All rights reserved.
//

#import "PZRequestResult.h"

@implementation PZRequestResult
-(instancetype)initWithCode:(NSString *)code data:(id)data
{
    if (self = [super init]) {
        _code = [code copy];
        _data = data;
    }
    return self;
}

-(BOOL)isSuccessData
{
    return [_code isEqualToString:@"ok"];
}

@end
