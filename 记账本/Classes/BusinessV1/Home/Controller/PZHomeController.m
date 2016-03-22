//
//  PZHomeController.m
//  记账本
//
//  Created by FanYuepan on 16/3/14.
//  Copyright © 2016年 fyp. All rights reserved.
//
//滚动效果
//    UILabel *labelShow = [[UILabel alloc] init];
//    labelShow.frame = CGRectMake(0, 64, kMSScreenWidth, 44);
//    labelShow.text = @"我可以滚动哦";
//    [labelShow sizeToFit];
//    CGRect frame = labelShow.frame;
//    frame.origin.x = 320;
//    labelShow.frame = frame;
//    [self.view addSubview:labelShow];
//
//    [UIView beginAnimations:@"testAnimation" context:NULL];
//    [UIView setAnimationDuration:8.8f];
//    [UIView setAnimationCurve:UIViewAnimationCurveLinear];
//    [UIView setAnimationDelegate:self];
//    [UIView setAnimationRepeatAutoreverses:NO];
//    [UIView setAnimationRepeatCount:999999];
//
//    frame = labelShow.frame;
//    frame.origin.x = -frame.size.width;
//    labelShow.frame = frame;
//    [UIView commitAnimations];

#import "PZHomeController.h"
#import "MSCommon.h"
#import "PZAccountItemCell.h"
#import "PZCostItemCell.h"
#import "PZAddCostController.h"
#import "MSNavigationController.h"
#import "PZActionSheetItem.h"

#import "YCActionSheet.h"

#import "PZActionSheet.h"

static NSString *kPZAccountItemCellID = @"kPZAccountItemCellID";
static NSString *kPZCostItemCellID = @"kPZCostItemCellID";

@interface PZHomeController()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>
{
    UICollectionView *_collectionView;
    NSArray *iconTitles;
}
@end

@implementation PZHomeController

-(void)viewDidLoad
{
    [super viewDidLoad];
    [self loadData];
}

-(void)loadData
{
    iconTitles =  @[@{@"消费" : @"20000078"},
                    @{@"工资" : @"09999999"},
                    @{@"余额" : @"20000032"},
                    @{@"转账" : @"09999988"}];

}

-(void)buildUI
{
    self.title = @"首页";
    UICollectionViewFlowLayout *flowLayout= [[UICollectionViewFlowLayout alloc] init];
    CGFloat width = kMSScreenWidth / 4 - 5;
    flowLayout.itemSize = CGSizeMake( width, width);
    flowLayout.minimumInteritemSpacing = 0;
    flowLayout.minimumLineSpacing = 5;
    
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, kMSScreenWidth, width + 10) collectionViewLayout:flowLayout];
    collectionView.backgroundColor = [UIColor whiteColor];
    
    collectionView.delegate = self;
    collectionView.dataSource = self;
    
    [collectionView registerClass:[PZAccountItemCell class] forCellWithReuseIdentifier:kPZAccountItemCellID];
    [collectionView registerClass:[PZCostItemCell class] forCellWithReuseIdentifier:kPZCostItemCellID];
    
    [self.view addSubview:collectionView];
    _collectionView = collectionView;
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"添加消费" style:UIBarButtonItemStylePlain target:self action:@selector(presentAddViewController)];
    
    [super buildUI];
    
}

//返回section个数
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

//返回第一个section的item个数
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return iconTitles.count;
}

-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(5, 5, 5, 5);
}
//返回cell
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    PZAccountItemCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:kPZAccountItemCellID forIndexPath:indexPath];
    cell.backgroundColor = [UIColor whiteColor];
    NSInteger index = indexPath.row;
    NSDictionary *dict = iconTitles[index];
    NSString *key = [[dict allKeys] firstObject];
    [cell setIcon:[dict valueForKey:key] andTitle:key];
    return cell;
}


-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"被点击了");
}
//返回这个UICollectionView是否可以被选择
-(BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

#pragma mark selector
-(void)presentAddViewController
{
    [PZActionSheet showItem:^(id<PZActionSheetItemDelegate> item) {
        [item addWithTitle:@"范月盘1" icon:@"20000078" identifier:@"haha1"];
        [item addWithTitle:@"范月盘2" icon:@"20000078" identifier:@"haha2"];
        [item addWithTitle:@"范月盘3" icon:@"20000078" identifier:@"haha3"];
        [item addWithTitle:@"范月盘4" icon:@"20000078" identifier:@"haha4"];

    } didSelected:^(NSString *identifier) {
        NSLog(@"%@",identifier);
    }];
}
@end
