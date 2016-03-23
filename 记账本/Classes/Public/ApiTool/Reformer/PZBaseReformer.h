//
//  PZBaseReformer.h
//  记账本
//
//  Created by FanYuepan on 16/3/23.
//  Copyright © 2016年 fyp. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PZBaseRequest.h"

@interface PZBaseReformer : NSObject<ReformerProtocol>

- (NSDictionary *)reformData:(id)originData fromRequest:(PZBaseRequest *)request;

@end
