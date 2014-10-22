//
//  QuestionModel.m
//  北大爱思唯尔
//
//  Created by me2 on 14-9-11.
//  Copyright (c) 2014年 www.healthedu.cn 北大爱思唯尔教育. All rights reserved.
//

#import "QuestionModel.h"

@implementation QuestionModel


-(void)setAns:(NSArray *)ans{
    
    if (_ans != ans){
       
        _ans = ans;
        _dataArray = [[NSMutableArray alloc] init];
        for (NSDictionary *dic in _ans){
            QuestionModel *model = [[QuestionModel alloc] initWithContent:dic];
            [_dataArray addObject:model];
        }
        
        
    }
    
    
}

@end
