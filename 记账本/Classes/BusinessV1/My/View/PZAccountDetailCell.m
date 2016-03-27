//
//  PZAccountDetailCell.m
//  记账本
//
//  Created by 范月祥 on 16/3/27.
//  Copyright © 2016年 fyp. All rights reserved.
//

#import "PZAccountDetailCell.h"
#import "UIImage+MS.h"
#import "MSCommon.h"

@interface PZAccountDetailCell()

@property(nonatomic,assign) PZAccountDetailType type;
@property(nonatomic,strong) NSIndexPath *indexPath;
@property(nonatomic,weak)UITableView *myTableView;

@end

@implementation PZAccountDetailCell

+(instancetype)cellWithType:(PZAccountDetailType)type money:(float)money inTableView:(UITableView *)tableView atIndexPath:(NSIndexPath *)indexPath
{
    static NSString *PZMyAccountDetailCellID = @"PZMyAccountDetailCellID";
    PZAccountDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:PZMyAccountDetailCellID];
    if (cell == nil) {
        cell = [[PZAccountDetailCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:PZMyAccountDetailCellID];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.textLabel.font = [UIFont systemFontOfSize:14];
        cell.textLabel.textColor = [UIColor lightGrayColor];
        cell.detailTextLabel.textColor = kMSColor(238, 106, 94);
    }
    cell.myTableView = tableView;
    cell.indexPath = indexPath;
    cell.money = money;
    cell.type = type;
    return  cell;
}

-(void)setMoney:(float)money {
    _money = money;
    self.detailTextLabel.text = [NSString stringWithFormat:@"%.2f",money];
}
-(void)setType:(PZAccountDetailType)type
{
    NSString *title;
    NSString *image;
    /*
     @[@{@"消费" : @"20000078"},
     @{@"工资" : @"09999999"},
     @{@"余额" : @"20000032"},
     @{@"转账" : @"09999988"}];
     */
    switch (type) {
        case PZAccountDetailTypeCost:{
            title = @"消费";
            image = @"20000078";
        }
            break;
        case PZAccountDetailTypeLast:{
            title = @"存款";
            image = @"20000032";
        }
            break;
        case PZAccountDetailTypeSalary:{
            title = @"工资";
            image = @"09999999";
        }
            break;
        case PZAccountDetailTypeTransIn:{
            title = @"转入";
            image = @"09999988";
        }
            break;
        case PZAccountDetailTypeTransOut:{
            title = @"转出";
            image = @"09999988";
        }
            break;
            
        default:
            break;
    }
    self.textLabel.text = title;
    self.imageView.image = [UIImage imageNamed:image];

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
