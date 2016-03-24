//
//  PZResponseValidate.h
//  记账本
//
//  Created by FanYuepan on 16/3/24.
//  Copyright © 2016年 fyp. All rights reserved.
//
/**
 *  对返回结果进行验证
 */

#import <Foundation/Foundation.h>

@interface PZResponseValidate : NSObject

-(NSDictionary *)validateWithData:(id)responseObject;

@end
