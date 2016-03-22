//
//  MSSummaryBottomView.m
//  记账本
//
//  Created by FanYuepan on 16/2/20.
//  Copyright © 2016年 fyp. All rights reserved.
//

#import "MSSummaryBottomView.h"
#import "UIImage+MS.h"
#import "MSSummaryDetailView.h"
#import "MSSummaryAll.h"

@implementation MSSummaryBottomView

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self buildUI];
    }
    return  self;
}

-(void)buildUI
{
    self.image = [UIImage resizeImage:@"common_card_background.png"];
    
    
}


-(void)setAll:(MSSummaryAll *)all
{
    _all = all;
    for (UIView *view in self.subviews) {
        [view removeFromSuperview];
    }
    double allMoney = all.allDetail.allMoney;
    //添加三条记录
    MSSummaryDetailView *detailView1 = [[MSSummaryDetailView alloc] initWithFrame:CGRectMake(0, 0, 0, 0) userid:1 all:allMoney value:all.userDetail1.allMoney];
    MSSummaryDetailView *detailView2 = [[MSSummaryDetailView alloc] initWithFrame:CGRectMake(0, 50, 0, 0) userid:2 all:allMoney value:all.userDetail2.allMoney];
    MSSummaryDetailView *detailView3 = [[MSSummaryDetailView alloc] initWithFrame:CGRectMake(0, 99, 0, 0)userid:3 all:allMoney value:all.userDetail3.allMoney];
    
    [self addSubview:detailView1];
    [self addSubview:detailView2];
    [self addSubview:detailView3];

}
@end
