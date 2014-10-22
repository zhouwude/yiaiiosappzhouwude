//
//  NavigationControllerEx.m
//  MultiLayerNavigation
//
//  Created by lyuan on 13-7-15.
//  Copyright (c) 2013年 Feather Chan. All rights reserved.
//

#import "NavigationControllerEx.h"
#import <QuartzCore/QuartzCore.h>
#import "GradeAlertView.h"

#define KEY_WINDOW  [[UIApplication sharedApplication] keyWindow]
//#define NOMALNAVI

@interface NavigationControllerEx ()

@end

@implementation NavigationControllerEx

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)dealloc
{
#if ! __has_feature(objc_arc)//木有用ARC
    [screenShotsList release];
    [backgroundView release];
    [shadowImageView release];
    [blackMask release];
    [lastScreenShotView release];
    [gradeView release];
    
    [super dealloc];
#endif
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    [self createUI];
}

- (void)viewDidAppear:(BOOL)animated
{
    [self.view.superview insertSubview:backgroundView belowSubview:self.view];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//ios < 6.0
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return [[self.viewControllers lastObject] shouldAutorotateToInterfaceOrientation:interfaceOrientation];
}

//ios >= 6.0
- (BOOL)shouldAutorotate
{
    return [[self.viewControllers lastObject] shouldAutorotate];
}

- (NSUInteger)supportedInterfaceOrientations
{
    return [[self.viewControllers lastObject] supportedInterfaceOrientations];
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation
{
    return [[self.viewControllers lastObject] preferredInterfaceOrientationForPresentation];
}

- (void)createUI
{
#ifdef NOMALNAVI
    canDragBack = NO;
#else
    canDragBack = YES;
#endif
    
    canScale = YES;
    defRect = self.view.frame;
    
    screenShotsList = [[NSMutableArray alloc] init];
    
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(paningGestureReceive:)];
    [pan delaysTouchesBegan];
    [self.view addGestureRecognizer:pan];
    
#if ! __has_feature(objc_arc)//木有用ARC
    [pan release];
#endif
    
    shadowImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
    shadowImageView.image = [UIImage imageNamed:@"img_shadow.png"];
    [self.view addSubview:shadowImageView];
    
    backgroundView = [[UIView alloc]initWithFrame:CGRectZero];
    
    blackMask = [[UIView alloc]initWithFrame:CGRectZero];
    blackMask.backgroundColor = [UIColor blackColor];
    [backgroundView addSubview:blackMask];
    
    lastScreenShotView = [[UIImageView alloc]initWithFrame:CGRectZero];
    [backgroundView insertSubview:lastScreenShotView belowSubview:blackMask];
    
    gradeView = [[GradeAlertView alloc] initWithFrame:CGRectZero];
    gradeView.hidden = YES;
    gradeView.parent = self;
    [self.view addSubview:gradeView];
    
    [self resize:defRect.size];
}

- (void)resize:(CGSize)size
{
    shadowImageView.frame = CGRectMake(-10, 0, 10, size.height);
    backgroundView.frame = CGRectMake(0, 0, size.width, size.height);
    blackMask.frame = CGRectMake(0, 0, size.width, size.height);
    lastScreenShotView.frame = CGRectMake(0, 0, size.width, size.height);
    gradeView.frame = CGRectMake(0, 0, size.width, size.height);
    [gradeView resize:CGSizeMake(size.width, size.height)];
}

- (void)setScale:(BOOL)enable
{
    canScale = enable;
}

- (void)showGradeAleart
{
    gradeView.hidden = NO;
}

- (void)hiddenGradeAlert
{
    gradeView.hidden = YES;
}

// override the push method
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    [screenShotsList addObject:[self capture]];//捕获当前controller的页面图片，放进数组中
    
    [super pushViewController:viewController animated:animated];
}

// override the pop method
- (UIViewController *)popViewControllerAnimated:(BOOL)animated
{
    [screenShotsList removeLastObject];//移除上一个congtroller照片
    lastScreenShotView.image = nil;//移除上一个congtroller的照片防止作坊转动作能看见这个残留照片
    
    return [super popViewControllerAnimated:animated];
}

- (NSArray *)popToRootViewControllerAnimated:(BOOL)animated
{
    [screenShotsList removeAllObjects];//现实所有congtroller的照片
    lastScreenShotView.image = nil;//移除上一个congtroller的照片防止作坊转动作能看见这个残留照片
    
    return [super popToRootViewControllerAnimated:animated];
}

#pragma mark - Utility Methods -

// get the current view screen shot
- (UIImage *)capture
{
    UIGraphicsBeginImageContextWithOptions(self.view.bounds.size, self.view.opaque, 0.0);
    [self.view.layer renderInContext:UIGraphicsGetCurrentContext()];
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

// set lastScreenShotView 's position and alpha when paning
- (void)moveViewWithX:(float)x
{
    //NSLog(@"Move to:%f",x);
    CGFloat width = defRect.size.width;
    x = x > width ? width : x;
    x = x < 0 ? 0 : x;
    
    CGRect frame = self.view.frame;
    frame.origin.x = x;
    self.view.frame = frame;
    
    float scale = canScale? (x/(2*width*10))+0.95:1;
    float alpha = 0.4 - (x/width);
    
    lastScreenShotView.transform = CGAffineTransformMakeScale(scale, scale);
    blackMask.alpha = alpha;
}

#pragma mark - Gesture Recognizer -

- (void)paningGestureReceive:(UIPanGestureRecognizer *)recoginzer
{
    // If the viewControllers has only one vc or disable the interaction, then return.
    if (self.viewControllers.count <= 1 || !canDragBack) {
        return;
    }
    
    // we get the touch position by the window's coordinate
    CGPoint touchPoint = [recoginzer locationInView:KEY_WINDOW];
    
    // begin paning, show the backgroundView(last screenshot),if not exist, create it.
    if (recoginzer.state == UIGestureRecognizerStateBegan) {
        isMoving = YES;
        startTouch = touchPoint;
        backgroundView.hidden = NO;
        lastScreenShotView.image = [screenShotsList lastObject];
        
        //End paning, always check that if it should move right or move left automatically
    } else if (recoginzer.state == UIGestureRecognizerStateEnded) {
        if (touchPoint.x - startTouch.x > 50) {
            [UIView animateWithDuration:0.3 animations:^{
                [self moveViewWithX:defRect.size.width];
            } completion:^(BOOL finished) {
                [self popViewControllerAnimated:NO];
                CGRect frame = self.view.frame;
                frame.origin.x = 0;
                self.view.frame = frame;
                isMoving = NO;
            }];
        } else {
            [UIView animateWithDuration:0.3 animations:^{
                [self moveViewWithX:0];
            } completion:^(BOOL finished) {
                isMoving = NO;
                backgroundView.hidden = YES;
            }];
        }
        return;
        
        // cancal panning, alway move to left side automatically
    } else if (recoginzer.state == UIGestureRecognizerStateCancelled) {
        [UIView animateWithDuration:0.3 animations:^{
            [self moveViewWithX:0];
        } completion:^(BOOL finished) {
            isMoving = NO;
            backgroundView.hidden = YES;
        }];
        
        return;
    }
    
    // it keeps move with touch
    if (isMoving) {
        [self moveViewWithX:touchPoint.x - startTouch.x];
    }
}

@end
