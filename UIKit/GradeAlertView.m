//
//  GradeAlertView.m
//  zhihuhd
//
//  Created by 无忧 on 13-12-16.
//  Copyright (c) 2013年 mobimac. All rights reserved.
//

#import "GradeAlertView.h"
#import "ImageCenter.h"
#import "ClickUtil.h"
#import "DateUtil.h"
#import "GradeHelper.h"

@implementation GradeAlertView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self createUI];
    }
    return self;
}

- (void)createUI
{
    coverView = [[UIView alloc] initWithFrame:CGRectZero];
    coverView.backgroundColor = [UIColor blackColor];
    coverView.alpha = 0.5;
    [self addSubview:coverView];
    
    bgImage = [[UIImageView alloc] initWithImage:[ImageCenter getBundleImage:@"gradeBG.png"]];
    bgImage.userInteractionEnabled = YES;
    [self addSubview:bgImage];
    
    closeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [closeButton setBackgroundImage:[ImageCenter getNamedImage:@"grade_close.png"] forState:UIControlStateNormal];
    [closeButton setBackgroundImage:[ImageCenter getNamedImage:@"grade_close_c.png"] forState:UIControlStateHighlighted];
    [closeButton addTarget:self action:@selector(clickClose) forControlEvents:UIControlEventTouchUpInside];
    [bgImage addSubview:closeButton];
    
    gradeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [gradeButton setBackgroundImage:[ImageCenter getNamedImage:@"grade_button.png"] forState:UIControlStateNormal];
    [gradeButton setBackgroundImage:[ImageCenter getNamedImage:@"grade_button_c.png"] forState:UIControlStateHighlighted];
    [gradeButton addTarget:self action:@selector(clickGrade) forControlEvents:UIControlEventTouchUpInside];
    [bgImage addSubview:gradeButton];
}

- (void)clickClose
{
    [self hiddenGradeAlert];
}
-(void)hiddenGradeAlert{
    if (self.parent != nil && [self.parent respondsToSelector:@selector(hiddenGradeAlert)]) {
        [self.parent performSelector:@selector(hiddenGradeAlert)];
    }
}
- (void)clickGrade
{
    [GradeHelper goToGrade];
    [self clickClose];
}

- (void)resize:(CGSize)size
{
    NSString* deviceType = [UIDevice currentDevice].model;
    NSRange range = [deviceType rangeOfString:@"iPad"];
    
    coverView.frame = CGRectMake(0, 0, size.width, size.height);
    if (range.location != NSNotFound) {
        bgImage.frame = CGRectMake((size.width-344)/2, (size.height-200)/2, 344, 200);
        gradeButton.frame = CGRectMake(bgImage.frame.size.width/2, bgImage.frame.size.height-54, bgImage.frame.size.width/2, 54);
        closeButton.frame = CGRectMake(0, bgImage.frame.size.height-54, bgImage.frame.size.width/2, 54);
    } else {
        bgImage.frame = CGRectMake((size.width-320)/2, (size.height-180)/2, 320, 180);
        gradeButton.frame = CGRectMake(160, bgImage.frame.size.height-56, 160, 56);
        closeButton.frame = CGRectMake(0, bgImage.frame.size.height-56, 160, 56);
    }
    
}

@end
