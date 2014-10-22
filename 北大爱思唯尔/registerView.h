//
//  registerView.h
//  北大爱思唯尔
//
//  Created by 周武德 on 14-10-8.
//  Copyright (c) 2014年 www.healthedu.cn 北大爱思唯尔教育. All rights reserved.
//

#import <UIKit/UIKit.h>
@class superSc;
@interface registerView : UIView<UIScrollViewDelegate,UITextFieldDelegate,UIAlertViewDelegate>
{
    
    UITextField *_mycardText;  // 帐号输入
    UITextField *_onePassText;  // 密码输入
    UITextField *_mailText;  // 密码输入
    UITextField *_nameText;
    UITextField *_trueNameText;
    UITextField *_memberText;
    UILabel *viewLabel;
    UILabel *_label;
    UILabel *_label2;
    UILabel *_label3;
    UILabel *_label4;
    UILabel *_label5;
    UILabel *_label6;
    superSc *scView;
    NSArray *textArray;
    NSArray *holderArray;
    NSArray *array;
    NSArray *array1;
    CGFloat height;
    NSArray *alertArray;
    NSString *flage;
    
}
@property(nonatomic,assign)id parent;
@property(nonatomic,strong)UITextField *textFieldSp;

@end
