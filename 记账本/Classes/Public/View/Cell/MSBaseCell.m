//
//  MSBaseCell.m
//  MSProduct
//
//  Created by FanYuepan on 16/2/4.
//  Copyright © 2016年 Macrosage. All rights reserved.
//

#import "MSBaseCell.h"
#import "UIImage+MS.h"

@implementation MSBaseCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        [self settingBg];
    }
    return  self;
}

//设定背景图片
- (void)settingBg
{
    UIImageView *bg = [[UIImageView alloc] init];
    bg.image = [UIImage resizeImage:@"common_card_background.png"];
    self.backgroundView = bg;
    _bg = bg;
    
    UIImageView *seletcedBg = [[UIImageView alloc] init];
    seletcedBg.image = [UIImage resizeImage:@"common_card_background_highlighted.png"];
    self.selectedBackgroundView = seletcedBg;
    _selectedBg = seletcedBg;
    
    self.backgroundColor = [UIColor clearColor];
}

-(void)addAllSubViews
{
    
}


-(UILabel *)addSingleLineLabel
{
    UILabel *label = [[UILabel alloc] init];
    [self.contentView addSubview:label];
    return label;
}
@end
