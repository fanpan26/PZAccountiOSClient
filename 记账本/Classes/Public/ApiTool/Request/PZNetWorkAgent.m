//
//  PZNetWorkAgent.m
//  记账本
//
//  Created by FanYuepan on 16/3/22.
//  Copyright © 2016年 fyp. All rights reserved.
//

#import "PZNetWorkAgent.h"
#import "PZBaseRequest.h"
#import "PZRequestConfig.h"
#import "PZNetReachability.h"

@interface PZNetWorkAgent()
{
    AFHTTPSessionManager *_manager;
    PZBaseRequest *_request;
    PZRequestConfig *_config;
}

@end

@implementation PZNetWorkAgent

-(instancetype)init
{
    if (self = [super init]) {
        _manager = [AFHTTPSessionManager manager];
        _config = [[PZRequestConfig alloc] init];
    }
    return self;
}
/**
 *  开始请求
 *
 *  @param request 请求基类
 */
-(void)startWithBaseRequest:(PZBaseRequest *)request
{
    _request = request;
    
    if (![[PZNetReachability sharedInstance] netReachable]) {
        if (request.delegate && [request.delegate respondsToSelector:@selector(requestFailedWithNetworkUnConnected)]) {

            [request.delegate requestFailedWithNetworkUnConnected];
        }
    }
    NSString *type;
    if (request.requestType == PZRequestTypeGet) {
        type = @"GET";
    }else if(request.requestType == PZRequestTypePost){
        type = @"POST";
    }
    
    NSString *path = [NSString stringWithFormat:@"%@%@",request.apiDomain,request.apiUrl];
    
    if (request.serializerType == PZRequestSerializerTypeHTTP) {
        _manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    }else{
        _manager.requestSerializer = [AFJSONRequestSerializer serializer];
    }
    [self requestWithType:type path:path header:request.header params:request.params delegate:request.delegate];
}


-(void)requestWithType:(NSString *)type path:(NSString *)path header:(NSDictionary *)header params:(NSDictionary *)params delegate:(id<PZBaseRequestDelegate>)delegate
{
    if (params == nil) {
        params = @{@"r":@"pz"};
    }
    
    NSMutableDictionary *dictionary = [NSMutableDictionary dictionaryWithDictionary:params];
    
    if (_config.defaultValidateParams != nil) {
       [_config.defaultValidateParams enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
           dictionary[key] = obj;
       }];
    }
    
    if (header && header.count > 0) {
        [header enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
            [_manager.requestSerializer setValue:obj forHTTPHeaderField:key];
        }];
    }
    
    if ([type isEqualToString:@"GET"]) {
        [_manager GET:path parameters:dictionary progress:nil
                               success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                                   if(delegate && [delegate respondsToSelector:@selector(requestSuccessWithRequest:)]){
                                       _request.responseObject = responseObject;
                                       [delegate requestSuccessWithRequest:_request];
                                   }
                                   
                               }
                               failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                                   if (delegate && [delegate respondsToSelector:@selector(requestFailedWithRequest:)]) {
                                       _request.error = error;
                                       [delegate requestFailedWithRequest:_request];
                                   }
                               }];
    }else if([type isEqualToString:@"POST"]){
        [_manager POST:path parameters:dictionary progress:nil
                                success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                                                                    }
                                failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                                    
                                }];
    }
    
}

@end
