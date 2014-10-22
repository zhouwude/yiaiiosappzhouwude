//
//  BaseModel.m
//  WXMovie
//
//  Created by 石显军 on 14-3-3.
//  Copyright (c) 2014年 无线互联3g学院. All rights reserved.
//

#import "BaseModel.h"

@implementation BaseModel

// 公开 初始化方法
- (id)initWithContent:(NSDictionary *)jsonDic
{
    self = [super init];
    if (self) {
        [self _setAttributes:jsonDic];
    }
    return self;
}

- (void)_setAttributes:(NSDictionary *)jsonDic
{
    // 1 获取JSON的所有key  [注意，JSON的key 与model属性值一致];
    NSDictionary *jsonKeyDic = [self _attributesMap:jsonDic];
    
    // 2 生成设置方法

    for(id key in jsonKeyDic)
    {
        // 生成setter方法
        SEL sel = [self _stringToSEL:key];
        
        // setName:
        if ([self respondsToSelector:sel])
        {
            // 取出json中的key
            id value = jsonKeyDic[key];
            
            // 取出json中value的值
            NSString *content = jsonDic[value];
            // 判断是否为空
            if ([content isEqual:[NSNull null]]) {
                content = @"";
            }
            
            // 调用setter方法  参数为value值
            [self performSelector:sel withObject:content];
        }
    }
    
}// 设置属性

- (NSDictionary *)_attributesMap:(NSDictionary *)jsonDic
{
    NSMutableDictionary *keys = [NSMutableDictionary dictionaryWithCapacity:[jsonDic count]];
    
    for (id jsonKey in jsonDic) {
        // 当JSON中key为id 由于id是关键字  因此生成一个新的key
        if ([jsonKey isEqualToString:@"id"]) {
            // 根据不同model 生成方法名称
            NSString *className = NSStringFromClass([self class]);
            // 拼接
            NSString *modelKey = [className stringByAppendingString:[jsonKey uppercaseString]];
            //NSLog(@"~~~~~%@",modelKey);
            
            [keys setValue:jsonKey forKey:modelKey];
        }else{
       
            [keys setValue:jsonKey forKey:jsonKey];
        }
    }
    
    return keys;
}

- (SEL)_stringToSEL:(NSString *)value
{
    //首字母大写
    NSString *first = [[value substringToIndex:1] uppercaseString];
    
    //截取首字母后一段的字符串
    NSString *end = [value substringFromIndex:1];
    // 拼接成setter方法
    NSString *setter = [NSString stringWithFormat:@"set%@%@:", first, end];
    
    //生成SEL类型变量
    return NSSelectorFromString(setter);
}
@end
