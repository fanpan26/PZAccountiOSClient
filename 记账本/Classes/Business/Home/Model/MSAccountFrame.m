//
//  MSAccountFrame.m
//  记账本
//
//  Created by FanYuepan on 16/2/16.
//  Copyright © 2016年 fyp. All rights reserved.
//

#import "MSAccountFrame.h"
#import "MSCommon.h"
#import "MSPhotoView.h"
#import "NSString+MS.h"
#import "MSAccount.h"


@implementation MSAccountFrame

-(void)setAccount:(MSAccount *)account
{
    _account = account;
    CGSize photoSize = [MSPhotoView photoSizeWithSize:MSPhotoViewSizeSmall];
    _fphoto = CGRectMake(kMSTableViewContentPaddingHorizontal, kMSTableViewContentPaddingVertical, photoSize.width, photoSize.height);
    
    CGFloat nameX = CGRectGetMaxX(_fphoto) + 2 * kMSTableViewContentPaddingHorizontal;
    CGSize nameSize = [_account.user.userName sizeSingleLineWithFont:[UIFont systemFontOfSize:15]];
    _fname = CGRectMake(nameX,_fphoto.origin.y, nameSize.width, nameSize.height);
    
    CGFloat detailX = nameX;
    CGFloat detailY = CGRectGetMaxY(_fname) + kMSTableViewContentPaddingVertical;
    CGSize detailSize = [_account.moneyDetail sizeSingleLineWithFont:[UIFont systemFontOfSize:12]];
    _fdetail = CGRectMake(detailX ,detailY,detailSize.width , detailSize.height);
    
    CGSize timeSize =[_account.addtime sizeSingleLineWithFont:[UIFont systemFontOfSize:13]];
    _ftime = CGRectMake(kMSScreenWidth - timeSize.width - kMSTableViewContentPaddingHorizontal ,_fphoto.origin.y,timeSize.width, timeSize.height);
    
    _cellHeight = CGRectGetMaxY(_fphoto) + 2 * kMSTableViewContentPaddingHorizontal;
}

@end
