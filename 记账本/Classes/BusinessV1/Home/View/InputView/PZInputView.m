//
//  PZInputView.m
//  记账本
//
//  Created by FanYuepan on 16/3/28.
//  Copyright © 2016年 fyp. All rights reserved.
//

#import "PZInputView.h"

@interface PZInputView()

@property(nonatomic,strong) UILabel *leftTitle;
@property(nonatomic,strong) UITextField *textField;

@end

@implementation PZInputView


-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self addSubview:self.leftTitle];
        [self addSubview:self.textField];
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    CGRect f = self.leftTitle.frame;
    f.origin.x  = 20;
    f.size.height = 44;
    self.leftTitle.frame = f;
    self.textField.frame = CGRectMake(self.leftTitle.frame.size.width + 25, 0, self.frame.size.width - self.leftTitle.frame.size.width - 25 , 44);
}

-(UILabel *)leftTitle
{
    if (_leftTitle == nil) {
        _leftTitle = [[UILabel alloc] init];
        _leftTitle.textColor  = [UIColor blackColor];
        _leftTitle.font = [UIFont systemFontOfSize:16 weight:bold];
    }
    return _leftTitle;
}

-(UITextField *)textField
{
    if (_textField == nil) {
        _textField = [[UITextField alloc] init];
        //_textField.placeholder = @"工资";
        _textField.keyboardType = UIKeyboardTypeDecimalPad;
        
    }
    return _textField;
}

-(void)setLeftTitleText:(NSString *)leftTitleText
{
    _leftTitleText = [leftTitleText copy];
    self.leftTitle.text = leftTitleText;
    [self.leftTitle sizeToFit];
}

-(void)setRightContentText:(NSString *)rightContentText
{
    _rightContentText = [rightContentText copy];
    _textField.text = _rightContentText;
}

-(void)setFrame:(CGRect)frame
{
    frame.size.height = 44;
    [super setFrame:frame];
}

-(NSString *)inputText
{
    return self.textField.text;
}

-(void)setIsTextReadOnly:(BOOL)isTextReadOnly
{
    _isTextReadOnly = isTextReadOnly;
    if (_isTextReadOnly) {
        self.textField.enabled = NO;
    }
}

@end
