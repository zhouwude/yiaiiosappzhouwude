//
//  LandedViewController.m
//  北大爱思唯尔
//
//  Created by 倒霉熊丶 on 14-7-1.
//  Copyright (c) 2014年 www.healthedu.cn 北大爱思唯尔教育. All rights reserved.
//

#import "LandedViewController.h"
#import "MainViewController.h"
#import "ASIHTTPRequest.h"
#import "MoreViewController.h"
#import "ASIFormDataRequest.h"
#import "SXJDataService.h"
#import "CentreViewController.h"
#import "personalCenterModel.h"
#import "AppDelegate.h"
#define KUserName @"userName"
#define KPassWord @"passWord"
#import "registerrViewController.h"

@interface LandedViewController ()

@property (nonatomic, strong)ASIFormDataRequest *request;

@end

@implementation LandedViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
        self.title = @"北大医爱";
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardShow:) name:UIKeyboardDidShowNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardHid:) name:UIKeyboardDidHideNotification object:nil];

        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self _loadTextField];
    
    [self _loadButton];
    
    
    // 数据持久化.
//    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    
    
}
-(void)viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBar.hidden = YES;
    if (DEFAULT(@"tempUserName")){
        _userText.text = DEFAULT(@"tempUserName");
    }
    if (DEFAULT(@"tempPassword")){
        _passText.text = DEFAULT(@"tempPassword");
    }
    [_lendView addSubview:_passText];

    
}
#if 1
-(void)keyBoardShow:(NSNotification *)infoData{
    
    NSDictionary *dict = [infoData userInfo];
    CGRect rect = [[dict objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue];
    CGFloat height = rect.size.height;
    CGFloat X = kScreenHeight-kNavgationHeight-kTabBarHeight-height;
    NSLog(@"!!!!!!!");
    if (_lendView.bottom>X){
        

        [UIView animateWithDuration:0.2 animations:^{
            
            [self.view setTop:-(_lendView.bottom-X)];
            
            
        } completion:^(BOOL finished) {
            
        }];
        
        
        
    }
    
    
    
    
}
#endif

-(void)keyBoardHid:(NSNotification *)info{
    
    
    [UIView animateWithDuration:0.2 animations:^{
       self.view.frame = [UIScreen mainScreen].bounds;
    } completion:^(BOOL finished) {
        
    }];
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)_loadTextField
{
    // logo
    _logoView = [[UIImageView alloc] initWithFrame:CGRectMake((kScreenWidth-158)/2, 70, 158, 125)];
//    _logoView.backgroundColor = [UIColor yellowColor];
    _logoView.image = [UIImage imageNamed:@"logo"];
    [self.view addSubview:_logoView];
    
    // 登陆框背景
    _lendView = [[UIImageView alloc] initWithFrame:CGRectMake((kScreenWidth-253)/2,_logoView.bottom+40, 253, 66)];
    _lendView.image = [UIImage imageNamed:@"登录框"];
    _lendView.userInteractionEnabled = YES;
    [self.view addSubview:_lendView];
    
    // 账户输入框
    _userText =[[UITextField alloc] initWithFrame:CGRectMake(50, 2, 190, 30)];
    _userText.delegate = self;
    _userText.placeholder = @"请填写用户名";
    _userText.borderStyle = UITextBorderStyleNone;
    _userText.keyboardType = UIKeyboardTypeASCIICapable;
   
    _userText.clearButtonMode = UITextFieldViewModeAlways;
    [_lendView addSubview:_userText];
    
    // 密码输入框
    _passText =[[UITextField alloc] initWithFrame:CGRectMake(_userText.left, _userText.bottom+2, 190, 30)];
    _passText.delegate = self;
    _passText.placeholder = @"请填写密码";
    _passText.clearButtonMode = UITextFieldViewModeAlways;
    _passText.borderStyle = UITextBorderStyleNone;
    _passText.keyboardType = UIKeyboardTypeASCIICapable;
    _passText.secureTextEntry = YES;
    
}

- (void)_loadButton
{
    UIButton *lendButton = [UIButton buttonWithType:UIButtonTypeCustom];
    // 设置frame
    lendButton.frame = CGRectMake(_lendView.left, _lendView.bottom+20, 253/2-5, 40);
    // 设置button标题
    [lendButton setTitle:@"登 陆" forState:UIControlStateNormal];
    lendButton.backgroundColor =kHodoGreen;
    lendButton.titleLabel.font = [UIFont boldSystemFontOfSize:17];
    lendButton.layer.cornerRadius = 3.0;
    lendButton.layer.borderWidth = 1.0;
    // 线的颜色
    lendButton.layer.borderColor = [UIColor clearColor].CGColor;
    [lendButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [lendButton addTarget:self action:@selector(lendInfo:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:lendButton];
    UIButton *lendButton1 = [UIButton buttonWithType:UIButtonTypeCustom];
    // 设置frame
    lendButton1.frame = CGRectMake(lendButton.right+10, lendButton.top, 253/2-5, 40);
    // 设置button标题
    [lendButton1 setTitle:@"注 册" forState:UIControlStateNormal];
    lendButton1.backgroundColor =kHodoGreen;
    lendButton1.titleLabel.font = [UIFont boldSystemFontOfSize:17];
    lendButton1.layer.cornerRadius = 3.0;
    lendButton1.layer.borderWidth = 1.0;
    // 线的颜色
    lendButton1.layer.borderColor = [UIColor clearColor].CGColor;
    [lendButton1 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [lendButton1 addTarget:self action:@selector(registerInfo:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:lendButton1];
    
    UILabel *yearLabel = [[UILabel alloc] initWithFrame:CGRectMake(kScreenWidth/2 - 100/2, kScreenHeight - 50-60, 100, 20)];
    NSDateFormatter *nsdf2=[[NSDateFormatter alloc] init];
    [nsdf2 setDateStyle:NSDateFormatterShortStyle];
    [nsdf2 setDateFormat:@"YYYY-MM-dd"];
    NSString *date=[nsdf2 stringFromDate:[NSDate date]];
    yearLabel.text = date;
    yearLabel.font = [UIFont systemFontOfSize:12];
    yearLabel.textColor = [UIColor colorWithRed:170/255.0 green:170/255.0 blue:170/255.0 alpha:1];
    yearLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:yearLabel];
    UILabel *wwwLabel = [[UILabel alloc] initWithFrame:CGRectMake(kScreenWidth/2 - 150/2, kScreenHeight - 35 -60 , 150, 20)];
    wwwLabel.text = @"www.yiaiwang.com.cn";
    wwwLabel.font = [UIFont systemFontOfSize:12];
    wwwLabel.textColor = [UIColor colorWithRed:170/255.0 green:170/255.0 blue:170/255.0 alpha:1];
    wwwLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:wwwLabel];

    
#pragma 注册
    /*
     UIImageView *orImgView = [[UIImageView alloc] initWithFrame:CGRectMake(lendButton.left, lendButton.bottom+20, 253, 31)];
     orImgView.image = [UIImage imageNamed:@"or"];
     [self.view addSubview:orImgView];
    UIButton *registerButton = [UIButton buttonWithType:UIButtonTypeCustom];
    // 设置frame
    registerButton.frame = CGRectMake(orImgView.left, orImgView.bottom+20, 253, 40);
    // 设置button标题
    [registerButton setTitle:@"注 册" forState:UIControlStateNormal];
    registerButton.backgroundColor =kHodoZhuCe;
    registerButton.titleLabel.font = [UIFont boldSystemFontOfSize:17];
    registerButton.layer.cornerRadius = 3.0;
    registerButton.layer.borderWidth = 1.0;
    // 线的颜色
    registerButton.layer.borderColor = [UIColor clearColor].CGColor;

    [registerButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [registerButton addTarget:self action:@selector(registerInfo:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:registerButton];
     */
    
}

- (void)lendInfo:(UIButton *)button
{
    
//    if (![self validateEmail:_userText.text]) {
//        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请输入正确格式的邮箱" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
//        [alert show];
//        return;
//    }
//    if (![self validatePassWord:_passText.text]) {
//        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"密码中不应含有特殊字符" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
//        [alert show];
//        return;
//    }
    
    [self _landedUser];

}

- (void)registerInfo:(UIButton *)button
{
    
    
    registerrViewController *registerVC = [[registerrViewController alloc] init];
    
    [self.navigationController pushViewController:registerVC animated:YES];

   

}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
//    [_userText resignFirstResponder];
//    [_passText resignFirstResponder];
    if (![_userText isExclusiveTouch]) {
        
        
        [_userText resignFirstResponder];
        
    }
    
    if (![_passText isExclusiveTouch]) {
        
        [_passText resignFirstResponder];
    }

    
}
#pragma mark - TextFieldDelegate
//- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
//{
//    if (_userText == textField) {
//        _userName = [textField.text stringByReplacingCharactersInRange:range withString:string];
//        if ([_userName length] > 20 && [self validateEmail:_userText.text]) {
//            textField.text = [_userName substringToIndex:20];
//            _alerView = [[CfAlertView alloc] initWithTitle:@"请输入正确的邮箱" message:@"或帐号长度大于20" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"重新输入", nil];
//            [_alerView show];
//            [_userText resignFirstResponder];
//            return NO;
//        }
//    }
//    return YES;
//}
//<input onkeyup="value=value.replace(/[\W]/g,'') " onbeforepaste="clipboardData.setData('text',clipboardData.getData('text').replace(/[^\d]/g,''))" ID="Text1" NAME="Text1">
//- (BOOL)validateEmail:(NSString *)email
//{
//    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
//    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
//    return [emailTest evaluateWithObject:email];
//}
//- (BOOL)validatePassWord:(NSString *)passWord
//{
//    NSString *emailRegex = @"^[A-Za-z0-9\u4E00-\u9FA5_-]+$";
//    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
//    return [emailTest evaluateWithObject:passWord];
//}
//
#pragma mark - Request Data
- (void)_landedUser
{
    __weak typeof(self) _weakThis = self;
    
//    KQZD20001  yiaiwang
    NSDictionary *params = @{@"r" : @"cme2014/api/logincheck", @"username" : _userText.text, @"password" : _passText.text};
    [SVProgressHUD showWithStatus:@"正在登录" maskType:SVProgressHUDMaskTypeClear];
    [SXJDataService requestURL:@"" method:@"Get" params:params completion:^(id result) {
    timer = [NSTimer scheduledTimerWithTimeInterval:15 target:self selector:@selector(testRE) userInfo:nil repeats:NO];
        if ([result isKindOfClass:[NSArray class]]) {
            NSString *message = [result objectAtIndex:0];
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:message delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alert show];
            [timer invalidate];
            return;
        }
        if ([result isKindOfClass:[NSDictionary class]]) {
            //NSLog(@"result : %@",result);
            personalCenterModel *model = [[personalCenterModel alloc] initWithContent:result];
            if (_ID!=nil){
                _ID = nil;
            }
            _ID = model.personalCenterModelID;
            AppDelegate *app = [UIApplication sharedApplication].delegate;
            app.shareID = _ID;
                        
            NSLog(@"登陆成功");
            loadFinish = YES;
            [timer invalidate];
            [SVProgressHUD showWithStatus:@"登录成功" maskType:SVProgressHUDMaskTypeClear];
            
            [SVProgressHUD dismiss];
            
            MainViewController *rootVC = [[MainViewController alloc] init];
//            UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:rootVC];
//            _weakThis.view.window.rootViewController = nav;
            [_weakThis presentViewController:rootVC animated:YES completion:^{
                [[ NSUserDefaults standardUserDefaults] setObject:LOGIN forKey:LOGIN];
                [[NSUserDefaults standardUserDefaults] synchronize];
                
                
            }];
            
        }
        
    } error:^(id error) {
        
    }];
}
-(void)testRE{
    if (!loadFinish){
        [SVProgressHUD showWithStatus:@"请检查网络后重新登录" maskType:SVProgressHUDMaskTypeClear];
       [UIView animateWithDuration:2 animations:^{
           [SVProgressHUD dismiss];
 
       }];
        
        
          }
    
    
}


@end
