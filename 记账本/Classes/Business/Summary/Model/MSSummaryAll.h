//
//  MSUserSummary.h
//  记账本
//
//  Created by FanYuepan on 16/2/20.
//  Copyright © 2016年 fyp. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MSSummaryDetail.h"


@interface MSSummaryAll : NSObject

@property(nonatomic,strong) MSSummaryDetail *userDetail1;//用户1
@property(nonatomic,strong) MSSummaryDetail *userDetail2;//用户2
@property(nonatomic,strong) MSSummaryDetail *userDetail3;//用户3
@property(nonatomic,strong) MSSummaryDetail *allDetail; //总共

@end
