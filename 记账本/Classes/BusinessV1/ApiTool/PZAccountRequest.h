//
//  PZAccountRequest.h
//  记账本
//
//  Created by FanYuepan on 16/3/23.
//  Copyright © 2016年 fyp. All rights reserved.
//

#import "PZBaseRequest.h"

@interface PZAccountRequest : PZBaseRequest

@property(nonatomic,strong,readonly) NSString *op;

@end
