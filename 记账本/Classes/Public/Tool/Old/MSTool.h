//
//  MSTool.h
//  记账本
//
//  Created by FanYuepan on 16/2/24.
//  Copyright © 2016年 fyp. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MSSingleton.h"

@interface MSTool : NSObject
single_interface(MSTool)

-(NSString *)getRandomNonce;

-(NSString *)getTimestamp;

-(NSString *)sha1WithKey:(NSString *)key;

-(NSString *)getSignatureWithAppKey:(NSString *)appKey nonce:(NSString *)nonce timestamp:(NSString *)timestamp;
@end
