//
//  MSBaseCell.h
//  MSProduct
//
//  Created by FanYuepan on 16/2/4.
//  Copyright © 2016年 Macrosage. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MSBaseCell : UITableViewCell
{
    UIImageView *_bg;//背景图
    UIImageView *_selectedBg;//选中背景图
}


-(UILabel *)addSingleLineLabel;

-(void)addAllSubViews;
@end
