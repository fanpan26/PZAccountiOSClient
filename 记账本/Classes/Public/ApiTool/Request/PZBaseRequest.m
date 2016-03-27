//
//  PZBaseApiManager.m
//  记账本
//
//  Created by FanYuepan on 16/3/22.
//  Copyright © 2016年 fyp. All rights reserved.
//

#import "PZBaseRequest.h"
#import "PZResponseValidate.h"
#import "PZRequestConfig.h"

@interface PZBaseRequest()
{
    PZResponseValidate *_validate;
}
@end

@implementation PZBaseRequest
/*
 
 @property(nonatomic,strong,readonly) NSString *apiDomain;
 @property(nonatomic,strong,readonly) NSString *apiUrl;
 @property(nonatomic,assign,readonly) PZRequestType requestType;
 @property(nonatomic,strong,readonly) NSDictionary *header;
 @property(nonatomic,strong,readonly) NSDictionary *params;
 @property(nonatomic,assign,readonly) PZRequestSerializerType serializerType;
 */

-(instancetype)init
{
    if (self = [super init]) {
        _validate = [[PZResponseValidate alloc] init];
    }
    return self;
}

-(NSString *)requestId
{
    return  [NSString stringWithFormat:@"pz_request_%@",NSStringFromClass([self class])];
}

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

-(id)fetchDataWithReformer:(id<ReformerProtocol>)reformer
{
    if (reformer == nil) {
        return self.responseObject;
    } else {
        return [reformer reformDataWithRequest:self];
    }
}

-(void)setResponseObject:(id)responseObject
{
    BOOL needValidate = [[PZRequestConfig sharedConfig] needValidateResponseObject];
    if (needValidate) {
        _responseObject = [_validate validateWithData:responseObject];
    }else{
        _responseObject = responseObject;
    }
}

@end
