//
//  NavigationControllerEx.h
//  MultiLayerNavigation
//
//  Created by lyuan on 13-7-15.
//  Copyright (c) 2013年 Feather Chan. All rights reserved.
//

#import <UIKit/UIKit.h>

@class GradeAlertView;

@interface NavigationControllerEx : UINavigationController
{
    NSMutableArray  *screenShotsList;
    UIView          *backgroundView;
    UIImageView     *shadowImageView;
    UIImageView     *lastScreenShotView;
    GradeAlertView  *gradeView;
    UIView          *blackMask;
    CGPoint         startTouch;
    CGRect          defRect;
    BOOL            canScale;
    BOOL            isMoving;
    BOOL            canDragBack;
}

- (void)showGradeAleart;
- (void)setScale:(BOOL)enable;

@end
