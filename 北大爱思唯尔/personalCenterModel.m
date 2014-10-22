//
//  personalCenterModel.m
//  北大爱思唯尔
//
//  Created by me2 on 14-8-27.
//  Copyright (c) 2014年 www.healthedu.cn 北大爱思唯尔教育. All rights reserved.
//

#import "personalCenterModel.h"

@implementation personalCenterModel

-(void)setCourse:(NSDictionary *)Course{
    if (_Course!= Course){
        _Course = Course;
        personalCenterModel *model = [[personalCenterModel alloc] initWithContent:_Course];
        
        _model = model;
        
    }
}

@end
