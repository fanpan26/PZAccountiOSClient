//
//  MSSummaryDetail.h
//  记账本
//
//  Created by FanYuepan on 16/2/20.
//  Copyright © 2016年 fyp. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MSCurrentUser.h"
@interface MSSummaryDetail : NSObject

@property(nonatomic,assign) double allMoney;
@property(nonatomic,readonly) MSCurrentUser *user;

-(instancetype)initWithMoney:(double)money userid:(NSInteger)userid;

@end
