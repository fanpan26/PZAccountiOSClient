//
//  PZBaseApiManager.m
//  记账本
//
//  Created by FanYuepan on 16/3/22.
//  Copyright © 2016年 fyp. All rights reserved.
//

#import "PZBaseRequest.h"

@implementation PZBaseRequest
/*
 
 @property(nonatomic,strong,readonly) NSString *apiDomain;
 @property(nonatomic,strong,readonly) NSString *apiUrl;
 @property(nonatomic,assign,readonly) PZRequestType requestType;
 @property(nonatomic,strong,readonly) NSDictionary *header;
 @property(nonatomic,strong,readonly) NSDictionary *params;
 @property(nonatomic,assign,readonly) PZRequestSerializerType serializerType;
 */

-(NSString *)apiDomain
{
    return @"http://imfyp.com";
}

-(NSString *)apiUrl
{
    return nil;
}

-(PZRequestType)requestType
{
    return  PZRequestTypeGet;
}

-(PZRequestSerializerType)serializerType
{
    return PZRequestSerializerTypeJSON;
}

-(NSDictionary *)header
{
    return  nil;
}

-(NSDictionary *)params
{
    return nil;
}

-(NSDictionary *)fetchDataWithReformer:(id<ReformerProtocol>)reformer
{
    if (reformer == nil) {
        return self.responseObject;
    } else {
        return [reformer reformDataWithManager:self];
    }
}

@end
