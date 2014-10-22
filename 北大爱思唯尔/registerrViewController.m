//
//  registerrViewController.m
//  北大爱思唯尔
//
//  Created by 周武德 on 14-9-28.
//  Copyright (c) 2014年 www.healthedu.cn 北大爱思唯尔教育. All rights reserved.
//

#import "registerrViewController.h"
#import "ProgressHUD.h"
@interface registerrViewController (){
    UITextView *view;
    CGRect frame;
    
}

@end

@implementation registerrViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardShow:) name:UIKeyboardDidShowNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardHid:) name:UIKeyboardDidHideNotification object:nil];
        
    }
    return self;
}
-(void)showProgressView{
    [[ProgressHUD instance] showProgressHD:YES inView:self.view info:@"正在注册，请等待..."];
    
}
-(void)hidProgressView{
    
    [[ProgressHUD instance] showProgressHD:NO inView:self.view info:@"正在注册，请等待..."];

    
}
-(void)test:(NSString *)str{
    _heightCount = [str floatValue];
    
    
}
-(void)keyBoardShow:(NSNotification *)infoData{
    
    NSDictionary *dict = [infoData userInfo];
    CGRect rect = [[dict objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue];
    CGFloat height = rect.size.height;
    CGFloat X = kScreenHeight-kNavgationHeight-kTabBarHeight-height;
    
    if (_heightCount>X){
        
        
        [UIView animateWithDuration:0.2 animations:^{
            [registerview setTop:-(_heightCount-X)];
            
            
        } completion:^(BOOL finished) {
            
        }];
    }
    
        
        
   
    
    
    
    
}


-(void)keyBoardHid:(NSNotification *)info{
    
    
    [UIView animateWithDuration:0.2 animations:^{
       
        [registerview setTop:0];
        
    } completion:^(BOOL finished) {
        
    }];
    
    
}



- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationController.navigationBar.hidden = NO;
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.view.backgroundColor = [UIColor whiteColor];
    [self loadData];
    [self createNai];
    
    
    //[self _textField];
    //
    //[self _loadButton];// Do any additional setup after loading the view.
}
-(void)createNai{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 0, 100, 30);
    button.tag = 1000;
    [button setTitle:@"同意条款" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    UIBarButtonItem *leftButton = [[UIBarButtonItem alloc] initWithCustomView:button];
    self.navigationItem.rightBarButtonItem = leftButton;
    [button addTarget:self action:@selector(buttonClick) forControlEvents:UIControlEventTouchUpInside];
  
    
    
}
-(void)buttonClick{
    [UIView animateWithDuration:1.0
    
     animations:^{
         view.hidden = YES;
         UIButton *button = (UIButton *)[self.view viewWithTag:1000];
         button.hidden = YES;
         self.navigationItem.rightBarButtonItem = nil;
         registerview = [[registerView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
         registerview.parent = self;
         //registerview.backgroundColor = [UIColor redColor];
         [self.view addSubview:registerview];
         
      }];
    
    
    
    
    
}
-(void)loadData{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"隐私政策" ofType:@"txt"];
    NSError *error;
    NSString *str = [[NSString alloc] initWithContentsOfFile:path encoding:NSUTF8StringEncoding error:&error];
   // NSLog(@"~~~~~~%@",error);
    
    //NSLog(@"~~~~~~%@",str);
    view = [[UITextView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth,kScreenHeight-kNavgationHeight-kTabBarHeight)];
    
    [self.view addSubview:view];
    view.editable = NO;
    
    view.text = str;
    
    
    
    
    
    
}
- (void)_textField
{
    
}// textField 的设置



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
}

#pragma mark - Private Method
- (void)dismissBack:(NSArray *)array
{
    
    [self.navigationController popToRootViewControllerAnimated:YES];
}





@end
