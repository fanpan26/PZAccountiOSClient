//
//  PZTransferCell.h
//  记账本
//
//  Created by FanYuepan on 16/3/15.
//  Copyright © 2016年 fyp. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *  @author fanyuepan, 16-03-15 22:03:16
 *
 *  转账交易记录Cell
 */
@class PZTransferModel;
@interface PZTransferCell : UITableViewCell

@property(nonatomic,strong) PZTransferModel *transfer;

@property(nonatomic,assign,readonly) CGFloat cellHeight;

@end
