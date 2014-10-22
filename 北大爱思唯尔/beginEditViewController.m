//
//  beginEditViewController.m
//  北大爱思唯尔
//
//  Created by 周武德 on 14-10-11.
//  Copyright (c) 2014年 www.healthedu.cn 北大爱思唯尔教育. All rights reserved.
//

#import "beginEditViewController.h"
#import "ColorUtil.h"
@interface beginEditViewController (){
    UITextField *changeTextField;
}

@end

@implementation beginEditViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    [self createNai];
    self.view.backgroundColor = [ColorUtil getColor:@"EBEBEB" alpha:1];
    
    changeTextField =[[UITextField alloc] init];
    [self.view addSubview:changeTextField];
    NSDictionary *views = NSDictionaryOfVariableBindings(changeTextField);
    changeTextField.translatesAutoresizingMaskIntoConstraints = NO;
    changeTextField.delegate = self;
    changeTextField.text = self.message;
    changeTextField.borderStyle = UITextBorderStyleNone;
    //changeTextField.borderStyle = UITextBorderStyleBezel;
    changeTextField.backgroundColor = [UIColor whiteColor];
    changeTextField.clearButtonMode = UITextFieldViewModeAlways;
    [self.view addSubview:changeTextField];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-10-[changeTextField(40)]" options:0 metrics:0 views:views]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-10-[changeTextField]-10-|" options:0 metrics:0 views:views]];
}
-(void)createNai{
    UIButton *button1 = [UIButton buttonWithType:UIButtonTypeCustom];
    button1.frame = CGRectMake(0, 0, 80, 30);
    [button1 setTitle:@"保存修改" forState:UIControlStateNormal];
    [button1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal ];
    UIBarButtonItem *leftButton1 = [[UIBarButtonItem alloc] initWithCustomView:button1];
    self.navigationItem.leftBarButtonItem = leftButton1;
    [button1 addTarget:self action:@selector(leftbuttonClick) forControlEvents:UIControlEventTouchUpInside];
    
    
    
}
-(void)backData:(NSString *)str textField:(NSString *)str1{
    if ([_parent respondsToSelector:@selector(backData: textField:)]){
        [_parent performSelector:@selector(backData: textField:) withObject:str withObject:str1];
    }
 
}
-(void)leftbuttonClick{
    [self backData:[NSString stringWithFormat:@"%d",_rowNum] textField:changeTextField.text];
    [self.navigationController popViewControllerAnimated:YES];
    
    
}
-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
