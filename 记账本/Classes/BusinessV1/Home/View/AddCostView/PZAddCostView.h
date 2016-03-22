//
//  PZAddCostView.h
//  记账本
//
//  Created by FanYuepan on 16/3/21.
//  Copyright © 2016年 fyp. All rights reserved.
//

#import <UIKit/UIKit.h>

#define kPZAddCostTypeCodeSalary @"SALARY"
#define kPZAddCostTypeCodeCost @"COST"
#define kPZAddCostTypeCodeLast @"LAST"
#define kPZAddCostTypeCodeTransfer @"TRANSFER"

@class PZAddCostView;
@protocol PZAddCostViewDelegate <NSObject>

@optional
-(void)costView:(PZAddCostView *)costView didSelectCellWithIdentifier:(NSString *)identifier;

@end

@interface PZAddCostView : UIView

@property(nonatomic,weak)id<PZAddCostViewDelegate> delegate;

@end
