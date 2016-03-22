//
//  MSAccountCell.m
//  记账本
//
//  Created by FanYuepan on 16/2/16.
//  Copyright © 2016年 fyp. All rights reserved.
//

#import "MSAccountCell.h"
#import "MSPhotoView.h"
#import "MSAccountFrame.h"
#import "MSAccount.h"
#import "UIImage+MS.h"
#import "MSCommon.h"

@interface MSAccountCell()
{
    MSPhotoView *_photoView;
    UILabel *_name;
    UILabel *_details;
    UILabel *_time;
}

@end

@implementation MSAccountCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self buildUI];
    }
    return self;
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


-(void)buildUI
{
    MSPhotoView *photoView = [[MSPhotoView alloc] initWithPhoto:nil size:MSPhotoViewSizeDefault];
    photoView.photoType = MSPhotoViewTypeSquareRectRound;
    [self.contentView addSubview:photoView];
    _photoView = photoView;
    
    UILabel *name = [[UILabel alloc] init];
    [self.contentView addSubview:name];
    name.font = [UIFont systemFontOfSize:15];
    name.textColor = [UIColor orangeColor];
    _name = name;
    
    UILabel *detail = [[UILabel alloc] init];
    [self.contentView addSubview:detail];
    detail.font = [UIFont systemFontOfSize:12];
    detail.textColor = kMSColor(149, 149, 149);
    _details = detail;
    
    UILabel *time = [[UILabel alloc] init];
    time.font = [UIFont systemFontOfSize:13];
    time.textColor = kMSColor(149, 149, 149)
    [self.contentView addSubview:time];
    _time = time;
}

-(void)setAccountFrame:(MSAccountFrame *)accountFrame
{
    _accountFrame = accountFrame;
    
    MSAccount *account = accountFrame.account;
    
    [_photoView setImage:account.user.userPhoto];
    _photoView.frame = accountFrame.fphoto;
    
    _name.text = account.user.userName;
    _name.frame = accountFrame.fname;
    
    _details.text = account.moneyDetail;
    _details.frame = accountFrame.fdetail;
    
    _time.text = account.addtime;
    _time.frame = accountFrame.ftime;
}

@end
