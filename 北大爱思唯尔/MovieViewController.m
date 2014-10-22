//
//  MovieViewController.m
//  北大爱思唯尔
//
//  Created by me2 on 14-9-9.
//  Copyright (c) 2014年 www.healthedu.cn 北大爱思唯尔教育. All rights reserved.
//

#import "MovieViewController.h"
#import "UIWebView+VideoControl.h"
#import "NetWorkDecideD.h"
@interface MovieViewController (){
    
    UIAlertView *view1;
    UIAlertView *view2;
    UIWebView *webView;
}

@end

@implementation MovieViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [NetWorkDecideD getNetwork];
    NSLog(@"~~~%d~~~~~%d",[NetWorkDecideD IsEnable3G],[NetWorkDecideD IsEnableWIFI]);
    [self createUI];
    if ([NetWorkDecideD IsEnable3G]&&![NetWorkDecideD IsEnableWIFI]){
        view1 = [[UIAlertView alloc] initWithTitle:@"提醒" message:@"你正在使用的是3G网，会使用大量流量!" delegate:self cancelButtonTitle:@"继续观看" otherButtonTitles:@"取消", nil];
        view1.delegate = self;
        
        [view1 show];
        
        
    }
    if ([NetWorkDecideD IsEnableWIFI]){
        view2 = [[UIAlertView alloc] initWithTitle:@"提醒" message:@"你使用的是wifi网络，可放心使用!" delegate:self cancelButtonTitle:nil otherButtonTitles:nil];
        view2.delegate = self;
        [view2 show];
        [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:_URL]]];
         [self performSelector:@selector(testTime) withObject:nil afterDelay:1.5];
        
    }
   
    
}

-(void)createUI{
    
    webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    [self.view addSubview:webView];
    //webView.backgroundColor =  [UIColor redColor];
    
    
    
}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (alertView==view1){
        if (buttonIndex == 0){
            
            [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:_URL]]];
            
        }else{
            [self.navigationController popViewControllerAnimated:YES];
        }
        
        
    }
    if(alertView == view2){
        
       
    
    }
}
-(void)testTime{
    [view2 dismissWithClickedButtonIndex:0 animated:YES];
    
   
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
}

@end
