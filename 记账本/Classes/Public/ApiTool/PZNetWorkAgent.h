//
//  PZNetWorkAgent.h
//  记账本
//
//  Created by FanYuepan on 16/3/22.
//  Copyright © 2016年 fyp. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"
#import "MSSingleton.h"


@class PZBaseRequest;
@interface PZNetWorkAgent : NSObject

-(void)startWithBaseRequest:(PZBaseRequest *)request;

@end
