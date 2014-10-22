//
//  registerView.m
//  北大爱思唯尔
//
//  Created by 周武德 on 14-10-8.
//  Copyright (c) 2014年 www.healthedu.cn 北大爱思唯尔教育. All rights reserved.
//

#import "registerView.h"
#import "superSc.h"
#import "JSONKit.h"
#import "SXJDataService.h"
#import "ProgressHUD.h"
@implementation registerView

@synthesize textFieldSp;
@synthesize parent;
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {

        _label = [[UILabel alloc] initWithFrame:CGRectZero];
        _label2 = [[UILabel alloc] initWithFrame:CGRectZero];
        _label3 = [[UILabel alloc] initWithFrame:CGRectZero];
        _label4 = [[UILabel alloc] initWithFrame:CGRectZero];
        _label5 = [[UILabel alloc] initWithFrame:CGRectZero];
        _label6 = [[UILabel alloc] initWithFrame:CGRectZero];
        _mycardText = [[UITextField alloc] initWithFrame:CGRectZero];
        _onePassText = [[UITextField alloc] initWithFrame:CGRectZero];
        _mailText = [[UITextField alloc] initWithFrame:CGRectZero];
        _nameText = [[UITextField alloc] initWithFrame:CGRectZero];
        _trueNameText = [[UITextField alloc] initWithFrame:CGRectZero];
        _memberText = [[UITextField alloc] initWithFrame:CGRectZero];
        textFieldSp = [[UITextField alloc] init];
        alertArray = @[@"必须为您的真实姓名",@"必须为真实的身份证号码",@"大于六位且必须为由字母数字下划线组成",@"必须大于六位",@"请填写您常用的邮箱地址",@"绑定一个会员帐号"];
       // [self addObserver:self forKeyPath:@"bottomHeight" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:nil];
        viewLabel = [[UILabel alloc] init];
        
        [self createSC];
        
        [self createUI];
        
    }
    return self;
}

-(void)test:(NSString *)str{
    
}
-(void)textFieldDidBeginEditing:(UITextField *)textField{
    textFieldSp = textField;
    viewLabel.hidden = NO;
    NSString *str = [NSString stringWithFormat:@"%f",textField.bottom];
    if ([parent respondsToSelector:@selector(test:)]){
        [parent performSelector:@selector(test:) withObject:str];
    }
    
    
    
    [self createView:alertArray[textField.tag-100] bottom:textField.bottom];
    
    [self performSelector:@selector(durationTime) withObject:nil afterDelay:1];
    
    
}
-(void)durationTime{
    [UIView animateWithDuration:1 animations:^{
        viewLabel.hidden = YES;
    }];
    
    
    
}

-(void)createSC{
    scView = [[superSc alloc] initWithFrame:CGRectMake(0,0, self.width, self.height)];
    scView.showsHorizontalScrollIndicator = NO;
    scView.showsVerticalScrollIndicator = NO;
    scView.bounces = NO;
    //scView.backgroundColor = [UIColor greenColor];
    [self addSubview:scView];
    
    
    
    
}
-(void)createUI{
    
    textArray = @[@"真实姓名:",@"身份证号码:",@"登录用户名:",@"密码:",@"电子邮箱地址:",@"会员号:"];
    holderArray = @[@"请填写真实姓名",@"请填写身份证号码",@"请输入登录用户名",@"请输入密码",@"请输入电子邮箱",@"请输入会员号码(选填)"];
    array = [[NSArray alloc] initWithObjects:_label,_label2,_label3,_label4,_label5,_label6, nil];    
    array1 = [[NSArray alloc] initWithObjects:_trueNameText,_mycardText,_nameText,_onePassText,_mailText,_memberText, nil];
    NSLog(@"!!!!!!~~~%d",array.count);
    for(int i=0;i<array.count;i++){
        
        UILabel *label = array[i];
        label.frame = CGRectMake(0,5+i*(30+10), 100, 30);
        label.textAlignment = NSTextAlignmentRight;
        label.text = textArray[i];
        label.font = [UIFont boldSystemFontOfSize:14];
        label.textColor = kHodoGreen;
        [scView addSubview:label];
        
        UITextField *textField = array1[i];
        textField.tag = i+100;
        
        textField.frame =CGRectMake(label.right+5, label.top+3, 190, 30);
        textField.delegate = self;
        textField.placeholder = holderArray[i];
        textField.borderStyle = UITextBorderStyleRoundedRect;
        textField.keyboardType = UIKeyboardTypeDefault;
        [scView addSubview:textField];
    }
    
    UIButton *sureButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    UILabel *tempLabel = [array1 lastObject];
    // 设置frame
    sureButton.frame = CGRectMake((kScreenWidth-240)/2, tempLabel.bottom+20, 240, 40);
    // 设置button标题
    [sureButton setTitle:@"开始注册" forState:UIControlStateNormal];
    sureButton.backgroundColor =kHodoGreen;
    sureButton.titleLabel.font = [UIFont boldSystemFontOfSize:17];
    sureButton.layer.cornerRadius = 3.0;
    sureButton.layer.borderWidth = 1.0;
    // 线的颜色
    sureButton.layer.borderColor = [UIColor clearColor].CGColor;
    [sureButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [sureButton addTarget:self action:@selector(sureInfo:) forControlEvents:UIControlEventTouchUpInside];
    [scView addSubview:sureButton];
}
-(void)sureInfo:(UIButton *)button{
    for (UITextField *inputText in array1){
        if (inputText.text.length >0){
            
            
            
            
            
            
        }else{
            UIAlertView *view = [[UIAlertView alloc] initWithTitle:@"提醒" message:@"请填写完整" delegate:self cancelButtonTitle:@"确认" otherButtonTitles:nil];
            [view show];
            return;
        }
        
        
        
        
    }
    
    [self cheakRegister];

}
-(void)cheakRegister{
    
    if ([self CheckInput:_mailText.text] &&[self validateIdentityCard:_mycardText.text]&&[self validatePassword:_onePassText.text]&&[self validateUserName:_nameText.text]){
        
        
        
        [self registerSuccess];
    
    }else{
        UIAlertView *view = [[UIAlertView alloc] initWithTitle:@"提醒" message:@"邮箱或身份证格式不正确或用户名和密码不符合要求,请检查" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [view show];
        
    }
    
    
    
    
}
- (void)dismissBack:(NSArray *)array{
    
}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex==0&&[flage integerValue]==1 ){
        
        if ([parent respondsToSelector:@selector(dismissBack:)]){
            NSUserDefaults *manager = [NSUserDefaults standardUserDefaults];
            [manager setObject:_nameText.text forKey:@"tempUserName"];
            [manager setObject:_onePassText.text forKey:@"tempPassword"];
            [manager synchronize];

            
            
            [parent performSelector:@selector(dismissBack:) withObject:array];
            
            
            
        }

        
        
        
    }
    
    
    
}
-(void)registerSuccess{
    NSArray *keyArray = @[@"true_name",@"cardno",@"user_name",@"password",@"email",@"vip_num"];
    int i=0;
    
    NSString *str = nil;
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    for (UITextField *myText in array1){
        
        [dic setValue:myText.text forKey:keyArray[i]];
        i++;
        
        
        
    }
    
    str = [dic JSONString];
    str = [NSString stringWithString:str];
    NSLog(@"~~~~%@",str);
    [self requestregister:str];
    
   
}
-(void)showProgressView{
    
    if ([parent respondsToSelector:@selector(showProgressView)]){
        [parent performSelector:@selector(showProgressView)];
        
    }
    
    
}
-(void)hidProgressView{
    
    if ([parent respondsToSelector:@selector(hidProgressView)]){
        [parent performSelector:@selector(hidProgressView)];
        
    }
    
}
-(void)requestregister:(NSString *)str{
    [self showProgressView];
    [SXJDataService requestURL:[NSString stringWithFormat:@"%@%@",@"?r=cme2014/api/reg&content=",str] method:@"GET" params:nil completion:^(id result) {
        
        NSString *str = [result objectForKey:@"code"];
        flage = str;
        [self hidProgressView];
        NSString *str1 = [result objectForKey:@"msg"];
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提醒" message:str1 delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alertView show];
        
        
        
        
        
        
    } error:^(id error) {
        
    }];
    
    

    
    
    
}
-(UILabel *)createView:(NSString *)text bottom:(CGFloat )bottomData{
    
    
    viewLabel.backgroundColor = [UIColor blackColor];
    viewLabel.alpha = 1;
    viewLabel.text = text;
    viewLabel.textColor  = [UIColor whiteColor];
    [viewLabel sizeToFit];
    viewLabel.frame = CGRectMake((kScreenWidth-viewLabel.width)/2, bottomData+2, viewLabel.width,viewLabel.height);
    [scView addSubview:viewLabel];
    return viewLabel;
}
#pragma 判断邮箱
-(BOOL)CheckInput:(NSString *)_text{
    NSString *Regex=@"[A-Z0-9a-z._%+-]+@[A-Z0-9a-z._]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest=[NSPredicate predicateWithFormat:@"SELF MATCHES %@",Regex];
    return [emailTest evaluateWithObject:_text];
    
}
#pragma 手机号码
-(BOOL) validateUserName:(NSString *)name
{
    NSString *userNameRegex = @"^[A-Za-z0-9]{6,20}+$";
    NSPredicate *userNamePredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",userNameRegex];
    BOOL B = [userNamePredicate evaluateWithObject:name];
    return B;
}


//密码
-(BOOL) validatePassword:(NSString *)passWord
{
    NSString *passWordRegex = @"^[a-zA-Z0-9]{6,20}+$";
    NSPredicate *passWordPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",passWordRegex];
    return [passWordPredicate evaluateWithObject:passWord];
}
-(BOOL) validateMobile:(NSString *)mobile
{
    //手机号以13， 15，18开头，八个 \d 数字字符
    NSString *phoneRegex = @"^((13[0-9])|(15[^4,\\D])|(18[0,0-9]))\\d{8}$";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    return [phoneTest evaluateWithObject:mobile];
}

-(BOOL)validateIdentityCard: (NSString *)identityCard
{
    BOOL flag;
    if (identityCard.length <= 0) {
        flag = NO;
        return flag;
    }
    NSString *regex2 = @"^(\\d{14}|\\d{17})(\\d|[xX])$";
    NSPredicate *identityCardPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex2];
    return [identityCardPredicate evaluateWithObject:identityCard];
}
@end
