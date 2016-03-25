//
//  PZLoadFailedView.m
//  记账本
//
//  Created by FanYuepan on 16/3/26.
//  Copyright © 2016年 fyp. All rights reserved.
//

#import "PZLoadFailedView.h"
#import "Masonry.h"

@implementation PZLoadFailedView

+(void)failedShow
{
    PZLoadFailedView *view  = [[self alloc] init];
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    [keyWindow addSubview:view];
    
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(keyWindow.mas_top).with.offset(keyWindow.bounds.size.height * 0.5 - 10);
        make.centerX.equalTo(keyWindow.mas_centerX);
    }];
}

-(instancetype)init
{
    if (self = [super init]) {
        self.image = [UIImage imageNamed:@"register_fail"];
    }
    return self;
}

@end
