//
//  MSAccountFrame.h
//  记账本
//
//  Created by FanYuepan on 16/2/16.
//  Copyright © 2016年 fyp. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


@class MSAccount;

@interface MSAccountFrame : NSObject

@property(nonatomic,assign) CGRect fphoto;
@property(nonatomic,assign) CGRect fname;
@property(nonatomic,assign) CGRect fdetail;
@property(nonatomic,assign) CGRect ftime;

@property(nonatomic,assign,readonly) CGFloat cellHeight;

@property(nonatomic,strong) MSAccount *account;
@end
