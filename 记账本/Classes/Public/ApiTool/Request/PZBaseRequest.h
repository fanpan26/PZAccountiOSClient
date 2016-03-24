//
//  PZBaseApiManager.h
//  记账本
//
//  Created by FanYuepan on 16/3/22.
//  Copyright © 2016年 fyp. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger,PZRequestType) {
    PZRequestTypeGet = 0,
    PZRequestTypePost = 1
};

typedef NS_ENUM(NSUInteger,PZRequestSerializerType) {
    PZRequestSerializerTypeHTTP = 0,
    PZRequestSerializerTypeJSON = 1
};

@class PZBaseRequest;
@class PZRequestResult;
@protocol PZBaseRequestDelegate <NSObject>

@optional
-(void)requestSuccessWithRequest:(__kindof PZBaseRequest *)request;
-(void)requestFailedWithRequest:(__kindof PZBaseRequest *)request;
-(void)requestFailedWithNetworkUnConnected;
@end

@protocol ReformerProtocol <NSObject>

@optional
-(PZRequestResult *)reformDataWithRequest:(PZBaseRequest *)request;

@end

@interface PZBaseRequest : NSObject

@property(nonatomic,weak) id<PZBaseRequestDelegate> delegate;

@property(nonatomic,strong,readonly) NSString *apiDomain;
@property(nonatomic,strong,readonly) NSString *apiUrl;
@property(nonatomic,assign,readonly) PZRequestType requestType;
@property(nonatomic,strong,readonly) NSDictionary *header;
@property(nonatomic,strong,readonly) NSDictionary *params;
@property(nonatomic,assign,readonly) PZRequestSerializerType serializerType;

@property(nonatomic,strong) id responseObject;
@property(nonatomic,strong) NSError *error;


-(id)fetchDataWithReformer:(id<ReformerProtocol>) reformer;

@end
