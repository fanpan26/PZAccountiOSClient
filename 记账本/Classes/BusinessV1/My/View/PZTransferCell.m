//
//  PZTransferCell.m
//  记账本
//
//  Created by FanYuepan on 16/3/15.
//  Copyright © 2016年 fyp. All rights reserved.
//

#import "PZTransferCell.h"
#import "MSPhotoView.h"
#import "PZTransferView.h"
#import "MSCommon.h"
#import "PZTransferModel.h"
#import "PZUser.h"

@interface PZTransferCell()

@property(nonatomic,strong) UILabel *timeLabel;
@property(nonatomic,strong) MSPhotoView *userPhotoView;
@property(nonatomic,strong) PZTransferView *transferView;

@end

@implementation PZTransferCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self addSubview:self.timeLabel];
        [self addSubview:self.userPhotoView];
        [self addSubview:self.transferView];
        self.backgroundColor = [UIColor clearColor];
    }
    return  self;
}

#pragma mark frame
-(void)layoutSubviews
{
    [super layoutSubviews];
    
    CGRect timeLabelFrame = self.timeLabel.frame;
    CGFloat width = timeLabelFrame.size.width;
    CGFloat timeLabelX = (kMSScreenWidth - width) * 0.5;
    CGFloat timeLabelY = 5;
    self.timeLabel.frame = CGRectMake(timeLabelX, timeLabelY, width, timeLabelFrame.size.height);
}

#pragma mark getter
-(UILabel *)timeLabel
{
    if (_timeLabel == nil) {
        _timeLabel = [[UILabel alloc] init];
        _timeLabel.font = [UIFont systemFontOfSize:12];
        _timeLabel.backgroundColor = [UIColor lightGrayColor];
        _timeLabel.text = @"3月14日 22:59";
        [_timeLabel sizeToFit];
    }
    return _timeLabel;
}

-(MSPhotoView *)userPhotoView
{
    if (_userPhotoView == nil) {
        _userPhotoView = [[MSPhotoView alloc] initWithPhoto:nil size:MSPhotoViewSizeDefault];
    }
    return _userPhotoView;
}

-(PZTransferView *)transferView
{
    if (_transferView == nil) {
        _transferView = [[PZTransferView alloc] init];
        _transferView.money = 1000.00f;
    }
    return _transferView;
}

-(void)setTransfer:(PZTransferModel *)transfer
{
    _transfer = transfer;
    self.transferView.money = transfer.money;
    self.transferView.isSelf = transfer.isSelf;
    
    [self.userPhotoView setImage:transfer.to_user.user_photo];
    
    CGFloat photoX;
    CGFloat photoY = 30.0f;
    
    CGFloat transferX;
    CGFloat transferY = photoY;
    
    CGSize photoSize = [MSPhotoView photoSizeWithSize:MSPhotoViewSizeDefault];
    CGSize transferSize = self.transferView.size;
    if (transfer.isSelf) {
        photoX = kMSScreenWidth - 10 - photoSize.width;
        transferX = photoX - transferSize.width - 10;
    }else{
        photoX = 10;
        transferX = 20 + photoSize.width;
    }
    self.transferView.frame = CGRectMake(transferX, transferY, transferSize.width, transferSize.height);
    self.userPhotoView.frame = CGRectMake(photoX, photoY, photoSize.width, photoSize.height);
}

-(CGFloat)cellHeight
{
    return 30 + self.transferView.size.height;
}



@end
