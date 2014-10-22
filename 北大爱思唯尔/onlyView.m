//
//  onlyView.m
//  北大爱思唯尔
//
//  Created by 周武德 on 14-10-13.
//  Copyright (c) 2014年 www.healthedu.cn 北大爱思唯尔教育. All rights reserved.
//

#import "onlyView.h"

@implementation onlyView

- (id)initWithFrame:(CGRect)frame{
  self =   [super initWithFrame:frame];
    if (self){
        [self createUI];
        
    }
    return self;
    
}
-(void)loadData:(NSString *)str{
    label.preferredMaxLayoutWidth = kScreenWidth-65;

    label.text = str;
    imageView.image = [UIImage imageNamed:@"1_06.jpg"];
    NSDictionary *views = NSDictionaryOfVariableBindings(label,imageView);
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-5-[imageView(15)]-10-[label]-5-|"options:0 metrics:0 views:views]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-8-[imageView(15)]"options:0 metrics:0 views:views]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-5-[label]-5-|"options:0 metrics:0 views:views]];
    
    
}
-(void)createUI{
    
    imageView = [[TapImageView alloc] init];
    imageView.translatesAutoresizingMaskIntoConstraints = NO;
    //imageView.image = [UIImage imageNamed:@"1_06.jpg"];
    imageView.parent = self;
    [self addSubview:imageView];
    
    label = [[UILabel alloc] init];
    label.numberOfLines = 0;
    label.preferredMaxLayoutWidth = kScreenWidth-65;
    label.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:label];
//    NSDictionary *views = NSDictionaryOfVariableBindings(label,imageView);
//    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-5-[imageView(15)]-10-[label]-5-|"options:0 metrics:0 views:views]];
//    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-8-[imageView(15)]"options:0 metrics:0 views:views]];
//    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-5-[label]-5-|"options:0 metrics:0 views:views]];
}
-(void)Click:(TapImageView *)view{
    
    if([_pratent respondsToSelector:@selector(Click:)]){
        [_pratent performSelector:@selector(Click:) withObject:view];
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
}

@end
