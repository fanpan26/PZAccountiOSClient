//
//  MSAccountCell.h
//  记账本
//
//  Created by FanYuepan on 16/2/16.
//  Copyright © 2016年 fyp. All rights reserved.
//

#import "MSBaseCell.h"

@class  MSAccountFrame;
@interface MSAccountCell : MSBaseCell

@property(nonatomic,strong) MSAccountFrame *accountFrame;;

@property(nonatomic,strong) NSIndexPath *indexPath;
@property(nonatomic,weak)UITableView *myTableView;

@end
