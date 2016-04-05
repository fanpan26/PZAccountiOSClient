//
//  PZInputView.h
//  记账本
//
//  Created by FanYuepan on 16/3/28.
//  Copyright © 2016年 fyp. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef  NS_ENUM(NSUInteger,PZInputViewKeyboardType){
    PZInputViewKeyboardTypeText = 1,
    PZInputViewKeyboardTypeNumber = 2
};

@interface PZInputView : UIView

@property(nonatomic,copy) NSString *leftTitleText;
@property(nonatomic,copy) NSString *rightContentText;
@property(nonatomic,strong,readonly) NSString *inputText;
@property(nonatomic,assign) BOOL isTextReadOnly;

@property(nonatomic,assign) PZInputViewKeyboardType keyboardType;

@end
