//
//  PZCostListCell.m
//  记账本
//
//  Created by FanYuepan on 16/3/16.
//  Copyright © 2016年 fyp. All rights reserved.
//

#import "PZCostListCell.h"
#import "MSPhotoView.h"
#import "Masonry.h"
#import "PZConfigFrame.h"
#import "MSCommon.h"
#import "UIImage+MS.h"

@interface PZCostListCell()

@property(nonatomic,strong) MSPhotoView *photoView;
@property(nonatomic,strong) UILabel *detailLabel;
@property(nonatomic,strong) UILabel *timeLabel;
@property(nonatomic,strong) UILabel *nameLabel;

@end

@implementation PZCostListCell

#pragma  mark life cycle
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self addAllSubViews];
    }
    return  self;
}

-(void)addAllSubViews
{
    [self.contentView addSubview:self.photoView];
    [self.contentView addSubview:self.detailLabel];
    [self.contentView addSubview:self.timeLabel];
    [self.contentView addSubview:self.nameLabel];
}

#pragma mark frame
-(void)layoutSubviews
{
    [super layoutSubviews];
    
    //头像
    CGSize size = [MSPhotoView photoSizeWithSize:MSPhotoViewSizeDefault];
    [self.photoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top).offset(kPZTableViewCellVerticalMargin);
        make.left.equalTo(self.contentView.mas_left).offset(kPZTableViewCellHorizontalMargin);
        make.size.mas_equalTo(size);
    }];
    //姓名
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top).offset(kPZTableViewCellVerticalMargin);
        make.left.equalTo(self.photoView.mas_right).offset(kPZTableViewCellHorizontalMargin);
    }];
    //详情
    [self.detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.nameLabel.mas_bottom).offset(kPZTableViewCellVerticalMargin);
        make.left.equalTo(self.photoView.mas_right).offset(kPZTableViewCellHorizontalMargin);
    }];
    //时间
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView.mas_right).offset(-kPZTableViewCellHorizontalMargin);
        make.top.equalTo(self.contentView.mas_top).offset(kPZTableViewCellVerticalMargin);
    }];
}


#pragma  mark getter setter
-(UILabel *)detailLabel
{
    if (_detailLabel == nil) {
        UILabel *label = [[UILabel alloc] init];
        _detailLabel = label;
        _detailLabel.font = kMSFont(15);
        _detailLabel.textColor = kPZCostListDetailColor
    }
    return _detailLabel;
}

-(UILabel *)timeLabel
{
    if (_timeLabel == nil) {
        UILabel *label = [[UILabel alloc] init];
        _timeLabel = label;
        _timeLabel.font = kMSFont(14);
        _timeLabel.textColor = kPZCostListDetailColor;
    }
    return _timeLabel;
}

-(UILabel *)nameLabel
{
    if (_nameLabel == nil) {
        UILabel *label = [[UILabel alloc] init];
        _nameLabel = label;
    }
    return _nameLabel;
}

-(MSPhotoView *)photoView
{
    if (_photoView == nil) {
        _photoView = [[MSPhotoView alloc] initWithPhoto:nil size:MSPhotoViewSizeDefault];
        _photoView.photoType = MSPhotoViewTypeSquareRectRound;
    }
    return _photoView;
}

-(void)setFrame:(CGRect)frame
{
    frame.size.width = kMSScreenWidth;
    frame.size.height = 70;
    [super setFrame:frame];
}

-(void)setDict:(NSDictionary *)dict
{
    _dict = dict;
    [self.photoView setImage:dict[@"photo"]];
    self.nameLabel.text = dict[@"name"];
    self.timeLabel.text = dict[@"time"];
    self.detailLabel.text = dict[@"detail"];
}

- (void)setIndexPath:(NSIndexPath *)indexPath
{
    _indexPath = indexPath;
    
    // 1.获得文件名
    NSInteger count = [_myTableView numberOfRowsInSection:indexPath.section];
    NSString *bgName = @"statusdetail_comment_background_middle.png";
    NSString *seletcedBgName = @"statusdetail_comment_background_middle_highlighted.png";
    if (count - 1 == indexPath.row) { // 末行
        bgName = @"statusdetail_comment_background_bottom.png";
        seletcedBgName = @"statusdetail_comment_background_bottom_highlighted.png";
    }
    
    // 2.设置背景图片
    _bg.image = [UIImage resizeImage:bgName];
    _selectedBg.image = [UIImage resizeImage:seletcedBgName];
}

@end
