//
//  ZCFBaseViewController.m
//  北大爱思唯尔
//
//  Created by 倒霉熊丶 on 14-6-13.
//  Copyright (c) 2014年 www.healthedu.cn 北大爱思唯尔教育. All rights reserved.
//

#import "ZCFBaseViewController.h"
#import "MainViewController.h"

@interface ZCFBaseViewController ()

@end

@implementation ZCFBaseViewController

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
    self.navigationController.navigationBar.translucent = NO;
    //self.edgesForExtendedLayout =UIRectEdgeNone ;
    if (self.navigationController.viewControllers.count >= 2 && self == [self.navigationController topViewController]) {
        // 添加平移手势
        UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(blackToRootVc:)];
        [self.view addGestureRecognizer:pan];

    }
    // 隐藏返回按钮
    [self.navigationItem setHidesBackButton:NO];


    }


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Action Medthos 平移
- (void)blackToRootVc:(UIPanGestureRecognizer *)pan
{
    CGPoint point = [pan translationInView:self.view];
    // 当用户左滑时, 直接返回
    if (point.x < 0) {
        // 当用户左滑时, 回到原点
        [UIView animateWithDuration:0.3 animations:^{
            self.navigationController.view.left = 0;
        }];
        return;
    }
    
    CGFloat scale = point.x / 320;    // 图片的比例
    CGFloat scale1 = scale *0.1 +0.9; // 阴影的比例
    
    // 当用户开始平移,或平移改变
    if (pan.state == UIGestureRecognizerStateChanged) {
        
        [UIView animateWithDuration:0.3 animations:^{
            
            self.navigationController.view.left = point.x;
            
            
            //            NSLog(@"oldView :　%@", [self oldView]);
            UIImageView *imgView = [self oldView];
            imgView.alpha = scale;
            // x轴缩放的比例，y轴的缩放的比例
            CATransform3D t = CATransform3DMakeScale(scale1, scale1, 0);
            [imgView.layer setTransform:t];
            
            
        }];
        
        // 当用户结束平移
    }else if (pan.state == UIGestureRecognizerStateEnded){
        
        if (point.x >= kMoveWidth) {
            
            /**
             * 此处需要注意，先讲“视图”滑动到320位置
             * 待到动画结束后，再将“视图”还原
             * 最后在使用无动画效果的pop，将视图控制器弹出
             */
            [UIView animateWithDuration:0.3 animations:^{
                
                self.navigationController.view.left = kScreenWidth;
                
                CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform"];
                // 持续时间
                animation.duration = 0.4;
                
                CATransform3D t = CATransform3DMakeScale(1, 1, 0);
                NSValue *value = [NSValue valueWithCATransform3D:t];
                
                CATransform3D t1 = CATransform3DMakeScale(scale1, scale1, 0);
                NSValue *value1 = [NSValue valueWithCATransform3D:t1];
                
                [animation setToValue:value];
                [animation setToValue:value1];
                
                [[self oldView].layer addAnimation:animation forKey:@"scale"];
            } completion:^(BOOL finished) {
                
                // 设置原来的坐标
                self.navigationController.view.left = 0;
                
                
                // 然后POP回去
                [self.navigationController popViewControllerAnimated:NO];
            }];
        }else {
            // 当用户滑动范围小于100时,
            [UIView animateWithDuration:0.3 animations:^{
                
                self.navigationController.view.left = 0;
            }];
        }
    }
    
    
}
#pragma mark - Public Methods
- (UIImageView *)oldView
{
    MainViewController *mainVC = (MainViewController *)self.tabBarController;
    
    return mainVC.oldView;
}

@end
