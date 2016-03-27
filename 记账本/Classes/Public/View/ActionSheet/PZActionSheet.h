//
//  PZActionSheet.h
//  记账本
//
//  Created by FanYuepan on 16/3/19.
//  Copyright © 2016年 fyp. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PZActionSheetItem.h"
/**
 *  actionSheet类型
 */
typedef NS_ENUM(NSInteger,PZActionSheetType){
    /**
     *  提示框，文字提示，确认取消等(一行一个)
     */
    PZActionSheetTypeAlert = 0,
    /**
     *  分享
     */
    PZActionSheetTypeShare = 1
};

@interface PZActionSheet : UIView

+(void)showItem:(void(^)(id<PZActionSheetItemDelegate>)) itemsBlock didSelected:(void(^)(NSString *))identifierBlock;

@end
