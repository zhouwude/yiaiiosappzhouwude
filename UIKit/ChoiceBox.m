//
//  ChoiceBox.m
//  mcarepatient
//
//  Created by mobimac on 12-8-8.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "ChoiceBox.h"
#import "ImageCenter.h"

@implementation ChoiceBox

@synthesize choiceImage, choiceLabel;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self creatUI];
    }
    return self;
}

- (void)creatUI
{
    choiceImage = [[UIImageView alloc] initWithFrame:CGRectZero];
    choiceImage.image = [ImageCenter getBundleImage:@"choice_box_focused.png"];
    [self addSubview:choiceImage];
    
    choiceLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    choiceLabel.backgroundColor = [UIColor clearColor];
    choiceLabel.font = [UIFont systemFontOfSize:14];
    choiceLabel.text = @"记住我的选择";
    [self addSubview:choiceLabel];
}

- (void)layoutSubviews
{
    choiceImage.frame = CGRectMake(0, 0, 20, 20);
    choiceLabel.frame = CGRectMake(25, 0, 200, 20);
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
