//
//  PZAccountDetailModel.h
//  记账本
//
//  Created by 范月祥 on 16/3/27.
//  Copyright © 2016年 fyp. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PZAccountDetailModel : NSObject

@property(nonatomic,copy) NSString *accountTypeImage;
@property(nonatomic,copy) NSString *accountTypeTitle;
@property(nonatomic,assign) float accountMoney;


+(NSArray *)defaultValues;
@end
