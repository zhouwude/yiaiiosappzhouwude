//
//  ToolBar.m
//  mcarepatient
//
//  Created by sam on 12-8-16.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "ToolBar.h"
#import "ColorUtil.h"

@implementation ToolBar

@synthesize parent;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self createUI];
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

- (void)createUI
{
    self.backgroundColor = [ColorUtil getColor:@"006CFF" alpha:0.75];
    [self layoutSubviews];
}

- (void)setButtons:(NSArray *)buttons isFull:(BOOL)isFull
{
    if (isFull == YES) {
        
    }
    for (int i=self.subviews.count-1; i>=0; i--) {
        UIView *subview = [self.subviews objectAtIndex:i];
        [subview removeFromSuperview];
    }
    for (int i=0; i<buttons.count; i++) {
        UIButton *button = [buttons objectAtIndex:i];
        button.tag = 100+i;
        [self addSubview:button];
    }
    for (int i=0; i<buttons.count-1; i++) {
        UILabel *line = [[UILabel alloc] initWithFrame:CGRectZero];
        line.backgroundColor = [UIColor whiteColor];
        line.tag = 200+i;
        [self addSubview:line];
    }
    count = buttons.count;
}

- (void)layoutSubviews
{
    CGFloat width = self.frame.size.width/count;
    CGFloat offset = 2;
    for (int i=0; i<count; i++) {
        UIButton *button = (UIButton *)[self viewWithTag:100+i];
        button.frame = CGRectMake(offset+width*i, 2, width-offset*2, 40);
        if (i < count-1) {
            UILabel *label = (UILabel *)[self viewWithTag:200+i];
            label.frame = CGRectMake(offset+width*(i+1)+1, 2, 1, 40);
        }
    }
}

+ (UIButton *)createButton:(NSString *)title target:(id)target action:(SEL)action
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:title forState:UIControlStateNormal];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return button;
}

@end
