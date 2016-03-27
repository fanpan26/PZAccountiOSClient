//
//  PZRequestResult.h
//  记账本
//
//  Created by FanYuepan on 16/3/24.
//  Copyright © 2016年 fyp. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PZRequestResult : NSObject

@property(nonatomic,strong,readonly) NSString *code;
@property(nonatomic,strong,readonly) id data;
@property(nonatomic,assign,readonly) BOOL isSuccessData;

-(instancetype)initWithCode:(NSString *)code data:(id)data;

@end
