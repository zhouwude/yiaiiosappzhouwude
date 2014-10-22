//
//  MainViewController.m
//  北大爱思唯尔
//
//  Created by 倒霉熊丶 on 14-7-1.
//  Copyright (c) 2014年 www.healthedu.cn 北大爱思唯尔教育. All rights reserved.
//

#import "MainViewController.h"
#import "CourseViewController.h"
#import "CentreViewController.h"
#import "MoreViewController.h"
#import "ZCFNavViewController.h"
#import "RemoteViewController.h"
#import "ItemView.h"



@interface MainViewController ()

- (void)_loadViewControllers;

- (void)_loadTabBar;

@end

@implementation MainViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        //self.title = @"dasd";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self _loadViewControllers];
    
    [self _loadTabBar];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Private Method
- (void)_loadViewControllers
{
    // 学习课程
    CourseViewController *courseVC = [[CourseViewController alloc] init];
    // 远程授课
    RemoteViewController *remoteVC = [[RemoteViewController alloc] init];
    
       // 个人中心
    CentreViewController *centreVC = [[CentreViewController alloc] init];
    // 更多
    MoreViewController *moreVC = [[MoreViewController alloc] init];
    
    // 将子视图加入到数组中
    NSArray *viewControl = @[courseVC, remoteVC, centreVC, moreVC];
    
    // 创建导航数组
    NSMutableArray *navs = [[NSMutableArray alloc] initWithCapacity:viewControl.count];
    // 加入根视图控制器
    for (int i = 0; i < viewControl.count; i++) {
        
        
         ZCFNavViewController *navigation = [[ZCFNavViewController alloc] initWithRootViewController:viewControl[i]];
        
       
        [navs addObject:navigation];
        
    }

    // 设置TabBar子视图控制器·
    [self setViewControllers:navs animated:YES];
}

- (void)_loadTabBar
{//隐藏TabBar视图
    self.tabBar.hidden = YES;
    self.selectedIndex = 2;
    //自定义TabBar视图
    tabBarView = [[UIImageView alloc] initWithFrame:self.tabBar.frame];
    NSLog(@"%@",NSStringFromCGRect(self.tabBar.frame));
    tabBarView.backgroundColor = [UIColor clearColor];
    tabBarView.userInteractionEnabled = YES;
    tabBarView.image = [UIImage imageNamed:@"导航背景"];
    [self.view addSubview:tabBarView];
    
    //存放图片名称
    self.images = @[@"面授课程.png",@"远程课程.png",@"个人中心.png",@"个人成绩.png"];
    self.selectImgs = @[@"面授课程-绿.png",@"远程课程-绿.png",@"个人中心-绿.png",@"个人成绩-绿.png"];
//    NSArray *titles = @[@"学习课程",@"远程授课" ,@"个人中心", @"更多"];
    
    //添加按钮
    CGFloat x = 0;
    for (int i = 0; i < 4; i++) {
        ItemView *TBitemView = [[ItemView alloc] initWithNamed:_images[i] title:nil];
//        NSLog(@"_image :%@",_images[i]);
        //设置子视图imageView的frame
        [TBitemView setItemViewFrame:CGRectMake(0, 3, kScreenWidth/4.0, kTabBarHeight)];
        //设置子视图title的frame
        [TBitemView setItemTitleFrame:CGRectMake(0, 32, kScreenWidth/4.0 , 10)];
        TBitemView.userInteractionEnabled = YES;
        TBitemView.tag = i;
        
        [TBitemView addTarget:self action:@selector(didSelectView:) forControlEvents:UIControlEventTouchUpInside];
        TBitemView.backgroundColor = [UIColor clearColor];
        TBitemView.frame = CGRectMake(x, 0, kScreenWidth/4.0, kTabBarHeight);
        [tabBarView addSubview:TBitemView];
        
        if (i == 2) {
            self.lastView = TBitemView;
            
            TBitemView.itemView.image = [UIImage imageNamed:_selectImgs[2]];
            TBitemView.itemTitle.textColor = kHodoGreen;
        }
        
        x += (kScreenWidth/4.0);
    }

    
}
- (void)didSelectView:(ItemView *)view

{
    
    
    
   
    if (view.tag != _lastView.tag){
       
        //[[NSNotificationCenter defaultCenter] postNotificationName:NOTIFICATION object:nil];
    self.lastView.itemView.image = [UIImage imageNamed:_images[_lastView.tag]];
    self.lastView.itemTitle.textColor = kHodoGray;
    }
    
    view.itemView.image = [UIImage imageNamed:_selectImgs[view.tag]];
    view.itemTitle.textColor = kHodoGreen;
    // 设置tabBar
    self.selectedIndex = view.tag;
    
    // 赋值上一次View
    self.lastView = view;
}

//-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context{
//    [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFICATION object:nil];
//}
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    // 如果已经创建， 不需要在创建“旧视图”
    if (_oldView == nil) {
        _oldView = [[UIImageView alloc] initWithFrame:self.view.bounds];
        [[self.view superview] insertSubview:_oldView atIndex:0];
    }
}
- (BOOL)shouldAutorotate
{
    NSLog(@"让不让我旋转?");
    return NO;
    
}

- (NSUInteger)supportedInterfaceOrientations {
    
    return UIInterfaceOrientationMaskAllButUpsideDown;
}


#pragma mark - Public Methods
- (void)setHiddenTabBarView:(BOOL)isHidden isAnimated:(BOOL)animated
{
    // 手动滑动，背景图片不需要
    if (!animated && !isHidden) {
        
        tabBarView.left = 0;
        return;
    }
    
    [UIView animateWithDuration:0.2 animations:^{
        
        if (isHidden) { // YES
            
            tabBarView.left = -kScreenWidth;
            self.tabBar.hidden = YES;
            
        }else {
            
            tabBarView.left = 0;
        }
    }];
}

@end
