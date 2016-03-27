//
//  PZTransferModel.h
//  记账本
//
//  Created by FanYuepan on 16/3/15.
//  Copyright © 2016年 fyp. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class PZUser;
@interface PZTransferModel : NSObject

@property(nonatomic,assign) NSInteger uid;
@property(nonatomic,strong) PZUser *from_user;
@property(nonatomic,strong) PZUser *to_user;
@property(nonatomic,assign) CGFloat money;
@property(nonatomic,assign) NSUInteger t;
@property(nonatomic,copy) NSString *tname;
@property(nonatomic,copy) NSString *addtime;
/**
 *  isSelf 是否是自己，如果是自己，就在右边
 */
@property(nonatomic,readonly,assign) BOOL isSelf;

+(instancetype)transfer;
+(instancetype)transfer1;
@end
