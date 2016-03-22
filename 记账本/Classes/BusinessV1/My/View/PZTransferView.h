//
//  PZTransformView.h
//  记账本
//
//  Created by FanYuepan on 16/3/15.
//  Copyright © 2016年 fyp. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PZTransferView : UIView

@property(nonatomic,assign) CGFloat money;
@property(nonatomic,assign) BOOL isSelf;

@property(nonatomic,assign,readonly) CGSize size;

@end
