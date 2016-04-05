//
//  PZMyController.m
//  记账本
//
//  Created by 范月祥 on 16/3/27.
//  Copyright © 2016年 fyp. All rights reserved.
//

#import "PZMyController.h"
#import "PZMyHeaderView.h"

#import "MSUserTool.h"
#import "MSCurrentUser.h"

#import "PZAccountDetailCell.h"

#import "PZNetWorkAgent.h"
#import "PZPersonalSummaryRequest.h"
#import "PZPersonalAccountReformer.h"
#import "PZPersonalAccountDetailModel.h"
#import "UIImage+MS.h"
#import "PZUploadImageRequest.h"

@interface PZMyController()<PZBaseRequestDelegate,PZMyHeaderViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@property(nonatomic,strong,readonly) NSArray *accountTypes;
@property(nonatomic,strong) NSArray *accountMoneys;
@property(nonatomic,strong) PZMyHeaderView *headerView;

@property(nonatomic,strong) PZPersonalAccountReformer *reformer;


@end

@implementation PZMyController

-(void)viewDidLoad
{
    [super viewDidLoad];
    
    [self showTitleLoading];
    [self loadData];
}

-(void)didHeaderStartedRefresh
{
    [self loadData];
}

-(void)loadData
{
    
    PZNetWorkAgent *agent = [[PZNetWorkAgent alloc] init];
    PZPersonalSummaryRequest *request = [[PZPersonalSummaryRequest alloc] init];
    request.delegate = self;
    [agent startWithBaseRequest:request];
}

#pragma mark network delegate

-(void)requestSuccessWithRequest:(__kindof PZBaseRequest *)request
{
    if ([request isKindOfClass:[PZPersonalSummaryRequest class]]) {
        PZRequestResult *result = [request fetchDataWithReformer:self.reformer];
        if(result.isSuccessData){
            PZPersonalAccountDetailModel *model = result.data;
            self.accountMoneys = model.values;
            
            self.headerView.photo = request.responseObject[@"data"][@"user"][@"user_photo"];
            self.headerView.name = request.responseObject[@"data"][@"user"][@"user_name"];
            [self reloadData];
        }
        [self hideTitleLoadingWithTitle:@"我的"];
        [self endHeaderRefreshing];
    }else{
        NSLog(@"头像上传成功");
        [self loadData];
    }
}
-(void)requestFailedWithRequest:(__kindof PZBaseRequest *)request
{
    NSLog(@"%@",request.error);
    [self hideTitleLoadingWithTitle:@"加载失败..."];
    [self endHeaderRefreshing];
}

-(void)requestFailedWithNetworkUnConnected
{
    NSLog(@"没有网络");
    [self hideTitleLoadingWithTitle:@"加载失败..."];
    [self endHeaderRefreshing];
}


-(void)didTapHeaderView:(PZMyHeaderView *)headerView
{
    UIImagePickerController *controller = [[UIImagePickerController alloc] init];
    controller.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    controller.allowsEditing = YES;
    controller.delegate = self;
    [self presentViewController:controller animated:YES completion:^{
        
    }];
}


-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
     [picker dismissViewControllerAnimated:YES completion:nil] ;
    
    UIImage *selectedImage = [info objectForKey:UIImagePickerControllerEditedImage];
    
    
    //创建一个bitmap的context
    //并把他设置成当前的context
    UIGraphicsBeginImageContext(CGSizeMake(80, 80));
    //绘制图片的大小
    [selectedImage drawInRect:CGRectMake(0, 0, 80, 80)];
    //从当前context中创建一个改变大小后的图片
    UIImage *endImage=UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    
    
    NSString *base64 = [endImage base64String];
    PZNetWorkAgent *agent = [[PZNetWorkAgent alloc] init];
    PZUploadImageRequest *request = [[PZUploadImageRequest alloc] initWithBase64:base64];
    request.delegate = self;
    [agent startWithBaseRequest:request];
    
}

-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:nil] ;
}
#pragma  mark private methods

-(void)buildUI
{
    [super buildUI];
    
    self.needFooterRefresh = NO;//不需要下拉刷新
    MSCurrentUser *user = [MSUserTool sharedMSUserTool].currentUser;
    PZMyHeaderView *headerView = [[PZMyHeaderView alloc] initWithPhoto:user.userPhoto name:user.userName];
    headerView.delegate = self;
    self.headerView = headerView;
    self.tableView.tableHeaderView = headerView;
    
}

#pragma mark UITableViewDelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.accountTypes.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    PZAccountDetailType type = [self.accountTypes[indexPath.row] integerValue];
    float money = [self.accountMoneys[indexPath.row] floatValue];
    PZAccountDetailCell *cell = [PZAccountDetailCell cellWithType:type money:money inTableView:tableView atIndexPath:indexPath];
    return cell;
}


#pragma mark getter setter
-(NSArray *)accountTypes
{
    return [NSArray arrayWithObjects:@(PZAccountDetailTypeCost),@(PZAccountDetailTypeLast),@(PZAccountDetailTypeSalary),@(PZAccountDetailTypeTransIn),@(PZAccountDetailTypeTransOut), nil];
}

-(NSArray *)accountMoneys
{
    if (_accountMoneys == nil) {
        _accountMoneys = [NSArray arrayWithObjects:@(0.00),@(0.00),@(0.00),@(0.00),@(0.00), nil];
    }
    return _accountMoneys;
}

-(PZPersonalAccountReformer *)reformer
{
    if (_reformer == nil) {
        _reformer = [[PZPersonalAccountReformer alloc] init];
    }
    return _reformer;
}
@end
