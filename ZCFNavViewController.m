//
//  ZCFNavViewController.m
//  北大爱思唯尔
//
//  Created by 倒霉熊丶 on 14-6-13.
//  Copyright (c) 2014年 www.healthedu.cn 北大爱思唯尔教育. All rights reserved.
//

#import "ZCFNavViewController.h"
#import "MainViewController.h"
#import "AppDelegate.h"
#import "MMDrawerBarButtonItem.h"
#import "MMExampleDrawerVisualStateManager.h"
#import "topicViewController.h"
#import "ListViewController.h"
@interface ZCFNavViewController ()

@end

@implementation ZCFNavViewController

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
    
    self.delegate = self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation Delegate
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    
//    AppDelegate *delegate = [[UIApplication sharedApplication] delegate];
    MainViewController *mainVC = (MainViewController *)viewController.tabBarController;
    
    // 压入2个视图控制器以上
    if (navigationController.viewControllers.count >= 2) {
        
        mainVC.oldView.hidden = NO;
        // 截取屏幕大小
        CGSize size = self.view.size;
        // 获取上下文
        
        UIGraphicsBeginImageContextWithOptions(size, NO, 0);
        // 将View拷贝到上下文中
        [[mainVC.view layer] renderInContext:UIGraphicsGetCurrentContext()];
        // 获取图片
        UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        mainVC.oldView.image = newImage;
        
//        [delegate.mmDrawController setOpenDrawerGestureModeMask:MMOpenDrawerGestureModeNone];
//        [delegate.mmDrawController setCloseDrawerGestureModeMask:MMCloseDrawerGestureModeNone];
        // 隐藏tabBar
        [mainVC setHiddenTabBarView:YES isAnimated:animated];
        
    }else{
        mainVC.oldView.hidden = YES;
//        [delegate.mmDrawController setOpenDrawerGestureModeMask:MMOpenDrawerGestureModeAll];
//        [delegate.mmDrawController setCloseDrawerGestureModeMask:MMCloseDrawerGestureModeAll];
        
        // 显示tabBar
        [mainVC setHiddenTabBarView:NO isAnimated:animated];
    }
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
