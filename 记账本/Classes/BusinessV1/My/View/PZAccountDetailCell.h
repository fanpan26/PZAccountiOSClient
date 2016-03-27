//
//  PZAccountDetailCell.h
//  记账本
//
//  Created by 范月祥 on 16/3/27.
//  Copyright © 2016年 fyp. All rights reserved.
//

#import "MSBaseCell.h"
#import "PZAccountDetailModel.h"

typedef NS_ENUM(NSUInteger,PZAccountDetailType){
    PZAccountDetailTypeCost = 0,
    PZAccountDetailTypeLast,
    PZAccountDetailTypeSalary,
    PZAccountDetailTypeTransIn,
    PZAccountDetailTypeTransOut
};

@interface PZAccountDetailCell : MSBaseCell

@property(nonatomic,assign) float money;

+ (instancetype)cellWithType:(PZAccountDetailType)type money:(float)money inTableView:(UITableView *)tableView atIndexPath:(NSIndexPath *) indexPath;

@end
