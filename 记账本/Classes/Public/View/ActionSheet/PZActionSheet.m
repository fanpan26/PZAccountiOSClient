//
//  PZActionSheet.m
//  记账本
//
//  Created by FanYuepan on 16/3/19.
//  Copyright © 2016年 fyp. All rights reserved.
//

/**
 *  模拟ActionSheet
 */

#import "PZActionSheet.h"
#import "PZActionSheetAlertCell.h"
#import "PZActionSheetItem.h"

#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height
#define kBackGroundColor [UIColor grayColor]

const CGFloat kPZActionItemHeight = 44;

static NSString *kPZActionItemCellID = @"kPZActionItemCellID";


@interface PZActionSheet()<UITableViewDataSource,UITableViewDelegate>

//@property(nonatomic,strong) UIView *sheetView;
@property(nonatomic,assign) PZActionSheetType type;
@property(nonatomic,strong) UITableView *sheetView;
@property(nonatomic,assign) CGFloat sheetViewHeight;

@property(nonatomic,strong) PZActionSheetItem *sheetItem;

@property(nonatomic,copy) void (^didSelectedBlock)(NSString *identifier);

@end


@implementation PZActionSheet


-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self buildUI];
    }
    return  self;
}

-(instancetype)initWithSheetType:(PZActionSheetType)type
{
    if (self = [self initWithFrame:CGRectZero]) {
        self.type = type;
    }
    return  self;
}
+(void)showItem:(void (^)(id<PZActionSheetItemDelegate>))itemsBlock didSelected:(void (^)(NSString *))identifierBlock
{
    PZActionSheet *sheet = [[PZActionSheet alloc] initWithSheetType:PZActionSheetTypeAlert];
    [sheet showItem:itemsBlock didSelected:identifierBlock];
}
-(void)showItem:(void (^)(id<PZActionSheetItemDelegate>))itemsBlock didSelected:(void (^)(NSString *))didSelectedBlock
{
   
    if (itemsBlock) {
        itemsBlock(self.sheetItem);
    }
    
    if (didSelectedBlock) {
        self.didSelectedBlock = didSelectedBlock;
    }
    
    [self showBottomView];
}

-(void)buildUI
{
    self.backgroundColor = [UIColor colorWithWhite:0 alpha:0.4];
    UIView *gesView = [[UIView alloc] initWithFrame:self.bounds];
    gesView.backgroundColor = [UIColor clearColor];
    [gesView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideSheet)]];
    [self addSubview:gesView];
    
    [self addSubview:self.sheetView];
}

-(void)showBottomView
{
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    [keyWindow addSubview:self];
    
    CGFloat y = self.frame.size.height;
    self.sheetViewHeight = (self.sheetItem.identifiers.count + 1) * 44 + 10;
    self.sheetView.frame  = CGRectMake(0, y, self.frame.size.width, self.sheetViewHeight);
    [UIView animateWithDuration:0.2 animations:^{
        CGRect sheetViewFrame = self.sheetView.frame;
        sheetViewFrame.origin.y = sheetViewFrame.origin.y - sheetViewFrame.size.height;
        self.sheetView.frame = sheetViewFrame;
    }];
}

-(void)hideSheet
{
    CGRect frame =  self.sheetView.frame;
    frame.origin.y += self.sheetViewHeight;
    [UIView animateWithDuration:0.2 animations:^{
        self.backgroundColor = [UIColor colorWithWhite:0 alpha:0];
        self.sheetView.frame = frame;
    } completion:^(BOOL finished) {
        self.hidden = YES;
        [self removeFromSuperview];

    }];
}


-(void)layoutSubviews
{
    [super layoutSubviews];
}

#pragma mark tableview datasource delegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return section == 1 ? 1 : self.sheetItem.identifiers.count;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return  2;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return  section == 1 ? 5 : 0;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    PZActionSheetAlertCell *cell = [tableView dequeueReusableCellWithIdentifier:kPZActionItemCellID];
    
    const NSInteger cancleSectionIndex = 1;
    if (indexPath.section == cancleSectionIndex) {
        [cell setIcon:nil title:@"取消"];
        cell.hasLine = NO;
    }else{
        NSString *title = self.sheetItem.titles[indexPath.row];
        NSString *icon = self.sheetItem.icons[indexPath.row];
        //NSString *identifier = self.sheetItem.identifiers[indexPath.row];
        [cell setIcon:icon title:title];
    }
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == 1) {
        [self hideSheet];
    }else{
        self.didSelectedBlock([NSString  stringWithFormat:@"%@",self.sheetItem.identifiers[indexPath.row]]);
    }
}



#pragma  mark getter setter

-(UIView *)sheetView
{
    if (_sheetView == nil) {
        _sheetView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        [_sheetView registerClass:[PZActionSheetAlertCell class] forCellReuseIdentifier:kPZActionItemCellID];
        _sheetView.dataSource = self;
        _sheetView.delegate = self;
        _sheetView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return  _sheetView;
}

-(CGFloat)sheetViewHeight
{
    if (_sheetViewHeight < 44) {
        return 44;
    }
    return _sheetViewHeight;
}

-(void)setType:(PZActionSheetType)type
{
    _type =type;
    switch (type) {
        case PZActionSheetTypeAlert:
        
            break;
        case PZActionSheetTypeShare:
            break;
    }
}


-(PZActionSheetItem *)sheetItem
{
    if (_sheetItem == nil) {
        _sheetItem = [[PZActionSheetItem alloc] init];
    }
    return  _sheetItem;
}
/**
 *  宽高
 *
 *  @param frame 设置frame为全屏
 */
-(void)setFrame:(CGRect)frame
{
    frame.size.width = kScreenWidth;
    frame.size.height = kScreenHeight;
    [super setFrame:frame];
}

@end
