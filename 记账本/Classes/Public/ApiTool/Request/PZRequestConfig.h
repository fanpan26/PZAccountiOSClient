//
//  PZRequestConfig.h
//  记账本
//
//  Created by FanYuepan on 16/3/23.
//  Copyright © 2016年 fyp. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PZRequestConfig : NSObject

+(instancetype)sharedConfig;

@property(nonatomic,strong,readonly) NSString *defaultApiDomain;
@property(nonatomic,strong,readonly) NSString *defaultApiUrl;
@property(nonatomic,strong,readonly) NSDictionary *defaultValidateParams;
@property(nonatomic,strong,readonly) NSDictionary *defaultHeaderValue;

@property(nonatomic,assign,readonly) BOOL needValidateResponseObject;

@end
