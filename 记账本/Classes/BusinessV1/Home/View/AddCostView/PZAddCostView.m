//
//  PZAddCostView.m
//  记账本
//
//  Created by FanYuepan on 16/3/21.
//  Copyright © 2016年 fyp. All rights reserved.
//

#import "PZAddCostView.h"
#import "UIImage+MS.h"

static NSString *PZAddCostViewCellID = @"PZAddCostViewCellID";



@interface PZAddCostView()<UITableViewDataSource,UITableViewDelegate>

@property(nonatomic,strong) UITableView *tableView;
@property(nonatomic,strong) NSArray *iconTitles;
@property(nonatomic,strong) NSArray *iconIdentifiers;
@property(nonatomic,strong) UIImageView *bgView;

@end

@implementation PZAddCostView

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self.bgView addSubview:self.tableView];
        [self addSubview:self.bgView];
    }
    return self;
}

#pragma mark uitableview delegate datasource

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:PZAddCostViewCellID];
    cell.backgroundColor = [UIColor clearColor];
    NSDictionary *dict = self.iconTitles[indexPath.row];
    NSString *key = [[dict allKeys] firstObject];
    cell.imageView.image = [UIImage imageNamed:[dict objectForKey:key]];
    cell.textLabel.text = key;
    return  cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"触发uitableview 事件");
    if ([self.delegate respondsToSelector:@selector(costView:didSelectCellWithIdentifier:)]) {
        [self.delegate costView:self didSelectCellWithIdentifier:self.iconIdentifiers[indexPath.row]];
    }
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
-(void)layoutSubviews
{
    [super layoutSubviews];
    
    CGRect tableViewFrame = self.bounds;
    tableViewFrame.origin.x = 10;
    tableViewFrame.origin.y = 10;
    self.tableView.frame = tableViewFrame;
    
    
    CGRect bgViewFrame = self.bounds;
    bgViewFrame.size.width += 20;
    self.bgView.frame = bgViewFrame;

}

#pragma mark getter setter
-(UITableView *)tableView
{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:self.bounds style:UITableViewStylePlain];
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:PZAddCostViewCellID];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = [UIColor clearColor];
        
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.userInteractionEnabled = YES;
    }
    return  _tableView;
}

-(NSArray *)iconTitles
{
    if (_iconTitles == nil) {
        _iconTitles =  @[@{@"消费" : @"20000078"},
                        @{@"工资" : @"09999999"},
                        @{@"余额" : @"20000032"},
                        @{@"转账" : @"09999988"}];
    }
    return _iconTitles;
}


-(NSArray *)iconIdentifiers
{
    if (_iconIdentifiers == nil) {
        _iconIdentifiers = @[kPZAddCostTypeCodeCost,kPZAddCostTypeCodeSalary,kPZAddCostTypeCodeLast,kPZAddCostTypeCodeTransfer];
    }
    return _iconIdentifiers;
}


-(UIImageView *)bgView
{
    if (_bgView == nil) {
        NSString *image = @"add_cost_bg";
        UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage resizeImage:image]];
        _bgView = imageView;
        _bgView.userInteractionEnabled = YES;
    }
    return _bgView;
}


-(void)setFrame:(CGRect)frame
{
    frame.size.width = 110;
    frame.size.height = 200;
    [super setFrame:frame];
}

@end
