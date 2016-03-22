//
//  MSChatUserFriendsCell.m
//  记账本
//
//  Created by FanYuepan on 16/2/23.
//  Copyright © 2016年 fyp. All rights reserved.
//

#import "MSChatUserFriendsCell.h"
#import "UIImage+MS.h"

@implementation MSChatUserFriendsCell


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
