//
//  MiddleView.m
//  北大爱思唯尔
//
//  Created by me2 on 14-9-4.
//  Copyright (c) 2014年 www.healthedu.cn 北大爱思唯尔教育. All rights reserved.
//

#import "MiddleView.h"
#import "UIViewExt.h"
@implementation MiddleView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self createUI];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeView:) name:ACTION object:nil];
    }
    return self;
}
-(void)changeView:(NSNotification *)info{
    
    CGPoint point = label2.frame.origin;
    point.x = [[info object]integerValue]*kScreenWidth/3;
    
    [UIView animateWithDuration:0.3 animations:^{
        label2.frame = CGRectMake(point.x, point.y, kScreenWidth/3, 3);
    }];
    
    
    
}

-(void)createUI{
    
    label2 = [[UILabel alloc] initWithFrame:CGRectMake(0, 47, kScreenWidth/3, 3)];
    label2.backgroundColor = [ColorUtil getColor:@"ADFF2F" alpha:1];
    [self addSubview:label2];
    self.backgroundColor = [ColorUtil getColor:@"F7F7F7" alpha:1];
    NSInteger distant = 0;
    NSArray *array = @[@"课程介绍",@"专家介绍",@"相关课程"];
    for (int i=0;i<3;i++){
        //NSInteger distant = kScreenWidth/3;
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(distant, 0, kScreenWidth/3, self.height);
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(distant, 0, kScreenWidth/3, self.height)];
//        label2 = [[UILabel alloc] initWithFrame:CGRectMake(distant, 47, kScreenWidth/3, 3)];
//        label2.backgroundColor = [ColorUtil getColor:@"ADFF2F" alpha:1];
//        if (i==0){
//            [self addSubview:label2];
//        }
        
        label.text = array[i];
        label.textColor = [ColorUtil getColor:@"363636" alpha:1];
        label.textAlignment = NSTextAlignmentCenter;
        label.font  = [UIFont systemFontOfSize:16];
        [self addSubview:label];
        label.userInteractionEnabled = YES;
        label2.userInteractionEnabled = YES;
        button.tag = i+100;
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button];
        distant += kScreenWidth/3;
        
        
        
        
        
    }
    
    
    
    
    
}
-(void)buttonClick:(UIButton *)button{
    
    
    
    CGPoint point = label2.frame.origin;
    point.x = (button.tag-100)*kScreenWidth/3;
    
    [UIView animateWithDuration:0.3 animations:^{
      label2.frame = CGRectMake(point.x, point.y, kScreenWidth/3, 3);
    }];
    //label2.frame = CGRectMake(point.x, point.y, kScreenWidth/3, 3);
    
    //NSLog(@"%f",point.x);
    [[NSNotificationCenter defaultCenter] postNotificationName:ACTION object:[NSString stringWithFormat:@"%d",button.tag-100]];
    
    
}


@end
