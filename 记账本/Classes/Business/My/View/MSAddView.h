//
//  MSAddView.h
//  记账本
//
//  Created by FanYuepan on 16/2/17.
//  Copyright © 2016年 fyp. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef  NS_ENUM(NSUInteger,MSAddViewType) {
    MSAddViewTypeSalary,
    MSAddViewTypeEveryDay,
    MSAddViewTypeLast
};

@class MSAddView;
@protocol MSAddViewDelegate<NSObject>

@optional
-(void)addView:(MSAddView *)addView btnClickedWithType:(MSAddViewType)type;

@end

@interface MSAddView : UIView

@property(nonatomic,weak) id<MSAddViewDelegate> delegate;

@end
