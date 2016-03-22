//
//  PZActionSheetAlertCell.m
//  记账本
//
//  Created by FanYuepan on 16/3/20.
//  Copyright © 2016年 fyp. All rights reserved.
//

#import "PZActionSheetAlertCell.h"
#import "UIColor+MS.h"

@interface PZActionSheetAlertCell()

@property(nonatomic,strong) UIImageView *iconView;
@property(nonatomic,strong) UILabel *titleLabel;
@property(nonatomic,strong) UIView *lineView;
@property(nonatomic,assign) BOOL hasIcon;
@end

@implementation PZActionSheetAlertCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self addSubview:self.iconView];
        [self addSubview:self.titleLabel];
        [self addSubview:self.lineView];
    }
    return self;
}

/**
 *  设置图片和标题
 *
 *  @param icon  图片
 *  @param title 标题
 */
-(void)setIcon:(NSString *)icon title:(NSString *)title
{
    self.hasIcon = icon != nil;
    if (self.hasIcon) {
        self.iconView.image = [UIImage imageNamed:icon];
    }
    self.titleLabel.text = title;
    [self.titleLabel sizeToFit];
    NSLog(@"%s",__func__);
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    //计算图标位置和文本位置
    CGRect titleFrame = self.titleLabel.frame;
    CGRect iconFrame = self.iconView.frame;
    CGFloat iconWidth = self.hasIcon ? 30.0f : 0.0f;
    CGFloat x = (self.bounds.size.width - (iconWidth + titleFrame.size.width)) * 0.5;
    
    iconFrame.origin.x = x;
    iconFrame.origin.y = 0;
    iconFrame.size = CGSizeMake(iconWidth , iconWidth);
    self.iconView.frame = iconFrame;
    
   
    titleFrame.origin.y = ((self.hasIcon ? iconFrame.size.height : self.frame.size.height) - titleFrame.size.height) * 0.5 ;
    titleFrame.origin.x = CGRectGetMaxX(iconFrame) + 5;
    self.titleLabel.frame = titleFrame;
    
    _lineView.frame = CGRectMake(0, self.frame.size.height - 1, self.frame.size.width, 1);
    
}




#pragma  mark getter setter 
-(UIImageView *)iconView
{
    if (_iconView == nil) {
        _iconView = [[UIImageView alloc] init];
    }
    return _iconView;
}


-(UILabel *)titleLabel
{
    if (_titleLabel == nil) {
        _titleLabel = [[UILabel alloc] init];
    }
    return  _titleLabel;
}

-(UIView *)lineView
{
    if (_lineView == nil) {
        _lineView = [[UIView alloc] init];
        _lineView.backgroundColor = [UIColor colorWithHexString:@"0xd2d5d9"];
    }
    return _lineView;
}

-(void)setHasIcon:(BOOL)hasIcon
{
    _hasIcon = hasIcon;
    self.iconView.hidden = !hasIcon;
}

-(void)setHasLine:(BOOL)hasLine
{
    _hasLine = hasLine;
    self.lineView.hidden = !_hasLine;

}

-(void)setFrame:(CGRect)frame
{
    frame.size.height = 44;
    [super setFrame:frame];
}
@end
