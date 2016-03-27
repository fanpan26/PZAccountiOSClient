
//
//  MSAddSalaryController.m
//  记账本
//
//  Created by FanYuepan on 16/2/17.
//  Copyright © 2016年 fyp. All rights reserved.
//

#import "MSAddController.h"
#import "MSCommon.h"
#import "MSDatePickerView.h"
#import "MSHttpFactory.h"
#import "MBProgressHUD.h"
#import "MSUserTool.h"

@interface MSAddController()<UITextFieldDelegate>
{
    UITextField *_textMonth;
    UITextField *_textMoney;
    UITextField *_textOther;
    
}

@end

@implementation MSAddController

-(void)viewDidLoad
{
    [super viewDidLoad];
    [self buildUI];
}

-(void)buildUI{
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIButton *btnBack = [UIButton buttonWithType:UIButtonTypeCustom];
    [btnBack setTitle:@"取消" forState:UIControlStateNormal];
    btnBack.frame = CGRectMake(kMSScreenWidth - 50, 10, 50, 44);
    [btnBack setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    [btnBack setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
    [btnBack addTarget:self action:@selector(btnBackClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnBack];
    
     MSDatePickerView *pickerView = [[MSDatePickerView alloc] initWithFrame:CGRectMake(0, kMSScreenHeight - 244, kMSScreenWidth, 244)];
    pickerView.confirmSelectCallBack = ^(NSString *date){
        _textMonth.text = date;
        [_textMonth resignFirstResponder];
    };
    /* {t:t,uid:2,month:'2016-2-16',cate:1,money:5000}*/
    UITextField *textMonth = [[UITextField alloc] init];
    textMonth.frame = CGRectMake(0, 84, kMSScreenWidth, 44);
    textMonth.placeholder = @"选择日期";
    textMonth.inputView = pickerView;
    textMonth.delegate = self;
    textMonth.text = [self getDate];
    [self.view addSubview:textMonth];
    _textMonth = textMonth;
    
    //金额
    UITextField *textMoney = [[UITextField alloc] init];
    textMoney.frame = CGRectMake(0, 148, kMSScreenWidth, 44);
    textMoney.placeholder = @"金额";
    textMoney.keyboardType = UIKeyboardTypeDecimalPad;
    [self.view addSubview:textMoney];
    _textMoney = textMoney;
    //备注
    if(_type == MSAddViewTypeEveryDay){
        UITextField *textOther = [[UITextField alloc] init];
        textOther.frame = CGRectMake(0, 212, kMSScreenWidth, 44);
        textOther.placeholder = @"备注";
        [self.view addSubview:textOther];
        _textOther = textOther;
    }
    
    CGFloat btnY = CGRectGetMaxY(_type == MSAddViewTypeEveryDay? _textOther.frame: textMoney.frame) + 20;
    UIButton *btnSave = [UIButton buttonWithType:UIButtonTypeCustom];
    [btnSave setTitle: @"保 存" forState:UIControlStateNormal];
    btnSave.frame = CGRectMake(0, btnY, kMSScreenWidth, 44);
    [btnSave setBackgroundColor:[UIColor orangeColor]];
    [btnSave addTarget:self action:@selector(btnSaveClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview: btnSave];
    
}

-(void)btnSaveClicked:(UIButton *)btn
{
    [self.view endEditing:YES];
    NSString *month = _textMonth.text;
    NSString *money = _textMoney.text;
    CGFloat moneyFloat = [money doubleValue];
    if(moneyFloat == 0){
        return;
    }
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    // Set the label text.
    hud.labelText = NSLocalizedString(@"正在保存...", @"HUD loading title");
    
    switch (_type) {
        case MSAddViewTypeEveryDay:{
            [[MSHttpFactory sharedMSHttpFactory] saveCostWithMoney:moneyFloat userid:0 other:_textOther.text success:^(id JSON) {
                
                hud.labelText = NSLocalizedString(@"保存成功", @"HUD loading title");
                [hud hide:YES afterDelay:0.5];

                [self btnBackClicked:nil];
            }];
        }
            break;
        case MSAddViewTypeLast:{
            [[MSHttpFactory sharedMSHttpFactory] postUserLastWithUserid:3 month:month money:moneyFloat issuccess:^(BOOL result) {
                if(result){
                    hud.labelText = NSLocalizedString(@"保存成功", @"HUD loading title");
                    [hud hide:YES afterDelay:0.5];
                    
                    [[MSUserTool sharedMSUserTool] setUserDefaultsValue:1 forKey:@"SUMMARYLIST"];//HOMELIST SUMMARYLIST
                    
                    [self returnHome];
                }else{
                    hud.labelText = NSLocalizedString(@"保存失败", @"HUD loading title");
                    [hud hide:YES afterDelay:0.5];
                }

            }];
        }
            break;
        case MSAddViewTypeSalary:{
            [[MSHttpFactory sharedMSHttpFactory] postUserSalaryWithUserid:1 month:month money:moneyFloat issuccess:^(BOOL result) {
                if(result){
                    hud.labelText = NSLocalizedString(@"保存成功", @"HUD loading title");
                    [hud hide:YES afterDelay:0.5];
                    
                    [[MSUserTool sharedMSUserTool] setUserDefaultsValue:1 forKey:@"SUMMARYSALARY"];
                    
                    [self returnHome];
                }else{
                    hud.labelText = NSLocalizedString(@"保存失败", @"HUD loading title");
                    [hud hide:YES afterDelay:0.5];
                }
            }];
        }
            break;
        default:
            break;
    }
    
}

-(void)btnBackClicked:(UIButton *)button
{
    [self dismissViewControllerAnimated:YES completion:nil];
}


-(void)returnHome
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

-(NSString *)getDate
{
    NSDate *date = [NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString *dateAndTime = [dateFormatter stringFromDate:date];
    return dateAndTime;
}



@end
