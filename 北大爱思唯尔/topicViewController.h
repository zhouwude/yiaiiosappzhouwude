//
//  topicViewController.h
//  北大爱思唯尔
//
//  Created by me2 on 14-9-9.
//  Copyright (c) 2014年 www.healthedu.cn 北大爱思唯尔教育. All rights reserved.
//

#import "ZCFBaseViewController.h"

@class TapImageView;

@interface topicViewController : ZCFBaseViewController<UIAlertViewDelegate>{
    
    UILabel *label;
    
    BOOL enterSelect;
    BOOL isSelect;
    BOOL isSelect1;

    BOOL isSelect2;

    BOOL isSelect3;
    NSInteger tempPage;
    NSMutableArray *array;
    
    UIAlertView *alert;
    NSInteger page;
}
@property(nonatomic,assign)BOOL enterSelect;
@property(nonatomic,strong)NSMutableArray *tagArray;
@property(nonatomic,strong)NSMutableArray *dataArray;
@property(nonatomic,strong)NSMutableDictionary *resultDict;
@property(nonatomic,strong)NSString *courseID;
@property(nonatomic,strong)TapImageView *tempView;
@property(nonatomic,strong)NSMutableDictionary *tempDict;
@property(nonatomic,strong)id parent;

@end
