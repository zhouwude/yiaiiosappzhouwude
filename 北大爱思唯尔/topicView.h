//
//  topicView.h
//  北大爱思唯尔
//
//  Created by me2 on 14-9-9.
//  Copyright (c) 2014年 www.healthedu.cn 北大爱思唯尔教育. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TapImageView.h"

@class onlyView;
@class QuestionModel;
@interface topicView : UIView<IamgeDelegate>{
    

    UIButton *selectButton;

    onlyView *view1;
    
    onlyView *view2;

    onlyView *view3;


    onlyView *view4;
    TapImageView *imageView1;
    TapImageView *imageView2;
    TapImageView *imageView3;
    TapImageView *imageView4;
    UILabel *label1;
    UILabel *label2;

    UILabel *label3;

    UILabel *label4;

    
    UIButton *backButton;
    UILabel *titleLabel;

    UIScrollView *sc;
    
    
    
    
}
-(void)createSomeUI:(QuestionModel *)array count:(NSInteger)count;
@property(nonatomic,strong)NSMutableArray *dataArray;
@property(nonatomic,strong)TapImageView *tempView;



@property(nonatomic,assign)NSInteger allCount;

@property(nonatomic,assign)id parent;

@end
