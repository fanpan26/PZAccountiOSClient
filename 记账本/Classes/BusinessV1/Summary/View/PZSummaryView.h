//
//  PZSummaryView.h
//  记账本
//
//  Created by FanYuepan on 16/3/24.
//  Copyright © 2016年 fyp. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PZAllSummary;
@interface PZSummaryView : UIView

@property(nonatomic,assign,readonly) CGSize viewSize;

@property(nonatomic,strong) PZAllSummary *data;

@end
