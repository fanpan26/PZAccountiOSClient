//
//  PZActionSheetAlertCell.h
//  记账本
//
//  Created by FanYuepan on 16/3/20.
//  Copyright © 2016年 fyp. All rights reserved.
//

/**
 *  普通cell，可以加图片
 */
#import <UIKit/UIKit.h>

@interface PZActionSheetAlertCell : UITableViewCell

-(void)setIcon:(NSString *)icon title:(NSString *)title;

@property(nonatomic,assign,getter=isHasLine) BOOL hasLine;
@end
