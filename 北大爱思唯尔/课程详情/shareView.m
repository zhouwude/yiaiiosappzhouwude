//
//  shareView.m
//  北大爱思唯尔
//
//  Created by me2 on 14-9-4.
//  Copyright (c) 2014年 www.healthedu.cn 北大爱思唯尔教育. All rights reserved.
//

#import "shareView.h"

//#import "UMFeedback.h"

@implementation shareView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
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
-(void)Click:(TapImageView *)view{
    if (self.shareBlock){
        self.shareBlock(view.tag);
    }
    
}
-(void)createUI{
    self.backgroundColor = [ColorUtil getColor:@"F8F8FF" alpha:1];
    NSArray *array = @[@"下载.png",@"收藏.png",@"分享.png"];
    NSArray *labelArray = @[@"下载",@"收藏",@"分享"];
    for (int i=0; i<3; i++) {
        TapImageView *imageView = [[TapImageView alloc] initWithFrame:CGRectMake(i*(90/3+30)+kScreenWidth-150, 0, 90/3,30 )];
        i==2||i==1?[imageView setHidden:NO]:[imageView setHidden:YES];
        imageView.parent = self;
        imageView.tag = i+100;
        imageView.image = [UIImage imageNamed:array[i]];
        [self addSubview:imageView];
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(kScreenWidth-150+i*(90/3+30), 30, 90/3,20 )];
        label.text = labelArray[i];
        label.font = [UIFont systemFontOfSize:12];
        label.textAlignment = NSTextAlignmentCenter;
        i==2||i==1?[label setHidden:NO]:[label setHidden:YES];
        [self addSubview:label];
    }
    
    
    
    
    
}

@end
