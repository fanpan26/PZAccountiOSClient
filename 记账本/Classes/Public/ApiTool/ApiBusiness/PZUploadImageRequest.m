//
//  PZUploadImageRequest.m
//  记账本
//
//  Created by FanYuepan on 16/3/30.
//  Copyright © 2016年 fyp. All rights reserved.
//

#import "PZUploadImageRequest.h"

@interface PZUploadImageRequest()
{
    NSString *_base64;
}

@end

@implementation PZUploadImageRequest

-(instancetype)initWithBase64:(NSString *)base64
{
    if (self = [super init]) {
        _base64 = base64;
    }
    return self;
}

-(NSString *)apiUrl
{
    return @"/api/upload.ashx";
}
-(PZRequestType)requestType
{
    return  PZRequestTypePost;
}

-(PZRequestSerializerType)serializerType
{
    return PZRequestSerializerTypeNone;
}

-(NSDictionary *)params
{
    return @{
        @"operate_user":@(self.userid),
        @"base64":_base64
    };
}
@end
