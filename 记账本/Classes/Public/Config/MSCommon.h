//
//  MSCommon.h
//  记账本
//
//  Created by FanYuepan on 16/2/17.
//  Copyright © 2016年 fyp. All rights reserved.
//

/*屏幕宽高*/
#define kMSScreenWidth [UIScreen mainScreen].bounds.size.width


#define kMSScreenHeight [UIScreen mainScreen].bounds.size.height

#define kMSTableViewContentPaddingVertical  10 
#define kMSTableViewContentPaddingHorizontal 10

/*颜色*/
#define kMSColor(r,g,b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0];
/*字体*/
#define kMSFont(f) [UIFont systemFontOfSize:(f)]
/*余额宝颜色*/
#define kMSYueColorTop kMSColor(225,62,32)
#define kMSYueColorBottom kMSColor(238,86,29)
#define kPZCostListDetailColor kMSColor(113,113,119)
/*
    ================================
 获取某个用户的工资 uid 为 0 则 全部
 http://imfyp.com/api/cost.ashx?t=salary&uid=1
 
 获取某个用户的每日开销
 http://imfyp.com/api/cost.ashx?t=everyday&uid=0&index=1
 
 获取某个用户的月结余记录
 http://imfyp.com/api/cost.ashx?t=last&uid=&index=1
 
 获取统计
 http://imfyp.com/api/cost.ashx?t=summary
 
 添加一条用户记录
 http://imfyp.com/api/addcost.ashx
 t：salary  everyday last
 uid:是用户id month：是月份 cate 是类型 money 是金额
 参数  ： {t:t,uid:2,month:'2016-2-16',cate:1,money:5000}
    ================================
 */

/*GET*/
#define kMSAPIGetUserDatas @"http://imfyp.com/api/cost.ashx"

/*POST*/
#define kMSAPIAddData @"http://imfyp.com/api/addcost.ashx"



/*转账cell*/
#define kPZAccountTransferCellID @"PZ_ACCOUNT_TRANSFER_CELL_ID"
