//
//  CfScrollView.m
//  北大爱思唯尔
//
//  Created by me2 on 14-8-27.
//  Copyright (c) 2014年 www.healthedu.cn 北大爱思唯尔教育. All rights reserved.
//

#import "CfScrollView.h"

@implementation CfScrollView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self createScroller];
    }
    return self;
}

-(void)createScroller{
    self.shouldGroupAccessibilityChildren = NO;
    self.showsHorizontalScrollIndicator = NO;
    self.pagingEnabled = YES;
    self.bounces = NO;
    self.pagingEnabled = YES;
    //self.frame = [[UIScreen mainScreen] bounds];
    self.contentSize = CGSizeMake(kScreenWidth*_ImageArray.count, kScreenHeight);
    //[self configImage];
    

}
-(void)configImage:(NSArray *)array{
    if (_ImageArray != nil){
        _ImageArray = nil;
    }
    _ImageArray = array;
    //NSLog(@"%@",_ImageArray);
    self.contentSize = CGSizeMake(kScreenWidth*_ImageArray.count, kScreenHeight);
    for (int i=0;i<_ImageArray.count;i++){
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(i*kScreenWidth, 0, kScreenWidth, kScreenHeight)];
        imageView.userInteractionEnabled = YES;
        imageView.image = [UIImage imageNamed:_ImageArray[i]];
        if (i ==_ImageArray.count - 1){
            //UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
           // button.frame = CGRectMake(, , , );
            
            [self createEnterButton:imageView];
            
            
        }
        [self addSubview:imageView];
        
        
        
    }
    
    
    
    
}
-(void)createEnterButton:(UIImageView *)imageView{
    
   UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(120,kScreenHeight-160,80 ,30);
    [button setTitle:@"进入" forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont boldSystemFontOfSize:17];
    button.tintColor = [UIColor whiteColor];
    button.layer.cornerRadius = 3.0;
    button.layer.borderWidth = 1.0;
    [button addTarget:self action:@selector(buttonClick) forControlEvents:UIControlEventTouchUpInside];
    [imageView addSubview:button];
    
    
    
}
-(void)buttonClick{
    
    
    
    
    
    if (self.backBlock){
        
        
        self.backBlock();
    }
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
