//
//  RemoteModel.m
//  北大爱思唯尔
//
//  Created by 倒霉熊丶 on 14-7-14.
//  Copyright (c) 2014年 www.healthedu.cn 北大爱思唯尔教育. All rights reserved.
//

#import "RemoteModel.h"

@implementation RemoteModel

- (void)setChilds:(NSArray *)childs
{
    if (_childs != childs) {
        _childs = [[NSMutableArray alloc] init];
        
        for (NSDictionary *value in childs) {
            RemoteModel *model = [[RemoteModel alloc] initWithContent:value];
            [_childs addObject:model];

        }
    }
}

@end
