//
//  PZBaseReformer.h
//  记账本
//
//  Created by FanYuepan on 16/3/23.
//  Copyright © 2016年 fyp. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PZBaseRequest.h"
#import "PZRequestResult.h"

@interface PZBaseReformer : NSObject<ReformerProtocol>

-(PZRequestResult *) reformData:(id)originData fromRequest:(PZBaseRequest *)request;

-(BOOL)isSuccessData:(id)originData;

@end
