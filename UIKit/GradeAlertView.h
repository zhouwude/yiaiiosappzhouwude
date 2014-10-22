//
//  GradeAlertView.h
//  zhihuhd
//
//  Created by 无忧 on 13-12-16.
//  Copyright (c) 2013年 mobimac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GradeAlertView : UIView
{
    UIView          *coverView;
    UIImageView     *bgImage;
    UIButton        *gradeButton;
    UIButton        *closeButton;
}

@property (nonatomic, assign) id parent;

- (void)resize:(CGSize)size;

@end
