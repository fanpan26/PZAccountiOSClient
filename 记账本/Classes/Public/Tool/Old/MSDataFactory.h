//
//  MSDataFactory.h
//  MSProduct
//
//  Created by FanYuepan on 16/2/5.
//  Copyright © 2016年 Macrosage. All rights reserved.
//
//数据工厂，和业务相关

#import <Foundation/Foundation.h>
#import "MSHttpManager.h"
#import "MSCommon.h"
#import "MSSingleton.h"

@interface MSDataFactory : NSObject

single_interface(MSDataFactory)

-(void)getWithURL:(NSString *)url params:(NSDictionary *)params success:(MSRequestResultSuccessCallBack)success failure:(MSRequestResultFailureCallBack)failure;

-(void)postWithURL:(NSString *)url params:(NSDictionary *)params success:(MSRequestResultSuccessCallBack)success failure:(MSRequestResultFailureCallBack)failure;

-(void)getStringWithURL:(NSString *)url params:(NSDictionary *)params success:(MSRequestResultSuccessCallBack)success failure:(MSRequestResultFailureCallBack)failure;


@end
