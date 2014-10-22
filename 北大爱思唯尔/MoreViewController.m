//
//  MoreViewController.m
//  北大爱思唯尔
//
//  Created by 倒霉熊丶 on 14-7-1.
//  Copyright (c) 2014年 www.healthedu.cn 北大爱思唯尔教育. All rights reserved.
//

#import "MoreViewController.h"
#import "SXJDataService.h"
#import "PersonageModel.h"
#import "ZilTableViewCell.h"
#import "HeadView.h"
#import "topicViewController.h"

@interface MoreViewController (){
    HeadView *_view;
}



@end

@implementation MoreViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"个人成绩";
       
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    //[self createNai];

    //[self _loadTableView];
    [self createUI];
    

    self.view.backgroundColor = [UIColor whiteColor];

}
-(void)createNai{
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 40, 30)];
    [button setTitle:@"答题" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(buttonClick) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *itemButton = [[UIBarButtonItem alloc] initWithCustomView:button];
    self.navigationItem.rightBarButtonItem = itemButton;
    
    
    
    
    
}
-(void)buttonClick{
    
    NSLog(@"答题成功");
    
    
}

#pragma mark - Perivate Method
-(void)createUI{
    
    _view = [[HeadView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight-kTabBarHeight)];
   // _view.backgroundColor = [UIColor redColor];
    [self.view addSubview:_view];
    
    
    
    
    
}


@end
