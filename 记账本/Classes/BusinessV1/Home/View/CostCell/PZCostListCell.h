//
//  PZCostListCell.h
//  记账本
//
//  Created by FanYuepan on 16/3/16.
//  Copyright © 2016年 fyp. All rights reserved.
//

#import "MSBaseCell.h"

@class PZAccountItem;
@interface PZCostListCell : MSBaseCell
//
//@property(nonatomic,strong) NSDictionary *dict;
@property(nonatomic,strong) PZAccountItem *accountDetail;

@property(nonatomic,strong) NSIndexPath *indexPath;
@property(nonatomic,weak)UITableView *myTableView;

@end
