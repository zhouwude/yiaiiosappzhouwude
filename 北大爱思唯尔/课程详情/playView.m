//
//  playView.m
//  北大爱思唯尔
//
//  Created by me2 on 14-9-4.
//  Copyright (c) 2014年 www.healthedu.cn 北大爱思唯尔教育. All rights reserved.
//

#import "playView.h"

//#import "TapImageView.h"
@implementation playView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self creatUI];
    }
    return self;
}
-(void)creatUI{
    self.userInteractionEnabled = YES;
    //self.backgroundColor = [ColorUtil getColor:@"F8F8FF" alpha:1];
       enTerLabel *label = [[enTerLabel alloc] init];
    label.textColor = [ColorUtil getColor:@"B3EE3A" alpha:1];
    label.text = @"进入随堂测试";
    label.translatesAutoresizingMaskIntoConstraints = NO;
    //label.textColor = [ColorUtil getColor:@"7CFC00" alpha:1];
    //label.font = [UIFont systemFontOfSize:15];
   // label.backgroundColor = [ColorUtil getColor:@"F5F5F5" alpha:1];
    [self addSubview:label];
    
    label.parent = self;
    NSDictionary *views = NSDictionaryOfVariableBindings(label);
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-0-[label]-0-|" options:0 metrics:0 views:views]];
    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[label]-0-|" options:0 metrics:0 views:views]];

    
    
    
}
-(void)Click2{
//    NSLog(@"进入学习");
//    if (self.block){
//        self.block();
//    }
//    
}


@end
