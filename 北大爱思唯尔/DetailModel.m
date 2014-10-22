//
//  DetailModel.m
//  北大爱思唯尔
//
//  Created by me2 on 14-9-1.
//  Copyright (c) 2014年 www.healthedu.cn 北大爱思唯尔教育. All rights reserved.
//

#import "DetailModel.h"

@implementation DetailModel
-(void)setCourseExpRel:(NSDictionary *)CourseExpRel{
    
    if (_CourseExpRel!= CourseExpRel){
        _CourseExpRel = CourseExpRel;
        DetailModel *model = [[DetailModel alloc] initWithContent:_CourseExpRel];
        
        _model = model;
        
    }
    
}
-(void)setDataZh:(NSDictionary *)dataZh{
    
    
    if (_dataZh!=dataZh){
        _dataZh = dataZh;
        DetailModel *model = [[DetailModel alloc] initWithContent:_dataZh];
       
        _dataModel = model;
        
        
    }
    
    
}

@end
