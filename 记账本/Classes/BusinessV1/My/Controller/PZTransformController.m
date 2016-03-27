//
//  PZTransformController.m
//  记账本
//
//  Created by FanYuepan on 16/3/15.
//  Copyright © 2016年 fyp. All rights reserved.
//

#import "PZTransformController.h"
#import "PZTransferCell.h"
#import "MSCommon.h"
#import "PZUser.h"
#import "PZTransferModel.h"

@interface PZTransformController()
{
    NSMutableArray *transferData;
}

@end

@implementation PZTransformController

-(void)viewDidLoad
{
    [super viewDidLoad];
    [self buildUI];
    [self loadData];
}

-(void)buildUI
{
    
    [self.tableView registerClass:[PZTransferCell class] forCellReuseIdentifier:kPZAccountTransferCellID];
    self.tableView.rowHeight = 120;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}

-(void)loadData
{
    if (transferData == nil) {
        transferData = [NSMutableArray array];
        [transferData addObject: [PZTransferModel transfer]];
        [transferData addObject: [PZTransferModel transfer1]];
        [transferData addObject: [PZTransferModel transfer]];
    }
}

#pragma mark tableViewDelegate

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return transferData.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    PZTransferCell *cell = [tableView dequeueReusableCellWithIdentifier:kPZAccountTransferCellID];
    cell.transfer = transferData[indexPath.row];
    return cell;
}

-(BOOL)tableView:(UITableView *)tableView shouldHighlightRowAtIndexPath:(NSIndexPath *)indexPath
{
    return  NO;
}


@end
