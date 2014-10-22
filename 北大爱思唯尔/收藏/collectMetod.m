//
//  collectMetod.m
//  北大爱思唯尔
//
//  Created by 周武德 on 14-9-24.
//  Copyright (c) 2014年 www.healthedu.cn 北大爱思唯尔教育. All rights reserved.
//

#import "collectMetod.h"
#import "DetailModel.h"

@implementation collectMetod
static collectMetod *methodSS = nil;
+(id)manager{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        methodSS= [[collectMetod alloc] init];
    });
    return methodSS;


}

#pragma 添加数据

-(void)insetData:(DetailModel *)model{
   
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
         [self addData:model];
    });
    
        
        
    
    
}
-(void)addData:(DetailModel *)model{
    self.collModel = [[collectModel alloc] init];
    
    LKDBHelper* globalHelper = [LKDBHelper getUsingLKDBHelper];
    
    [globalHelper createTableWithModelClass:[collectModel class]];
    _collModel.courseID = model.model.courseid;
    _collModel.speaker = model.speaker;
    _collModel.fullName = model.fullname;
    _collModel.price = model.model.price;
    [globalHelper insertToDB:_collModel];
    
    
    
}
#pragma 同步查找数据
+(NSMutableArray *)synFindData{
     NSMutableArray* arraySync = [collectModel searchWithWhere:nil orderBy:nil offset:0 count:100];
    
    return arraySync;
}
#pragma 清空数据库
+(void)dropAllTable{
    LKDBHelper* globalHelper = [LKDBHelper getUsingLKDBHelper];
    [globalHelper dropAllTable];
    
}
#pragma 清空表数据
-(void)clearTableData{
    [LKDBHelper clearTableData:[_collModel class]];
    
}
#pragma 获取某一列属性
+(NSArray *)findColumn:(NSString *)propertyName{
    NSArray* messageArray = [collectModel searchColumn:propertyName where:nil orderBy:nil offset:0 count:0];
    
    return messageArray;
}
#pragma 删除和更新
+(void)update:(NSString *)updateORdelete data:(id)wantData row:(NSInteger)row{
    
   LKDBHelper* globalHelper = [LKDBHelper getUsingLKDBHelper];
    [globalHelper search:[collectModel class] where:nil orderBy:nil offset:0 count:100 callback:^(NSMutableArray *array) {
        if ([updateORdelete isEqualToString:@"UPDATE"]){
            if ([wantData isKindOfClass:[NSString class]]){
                
                
                
                
                
            }
            
            
            
            
            
        }
        if ([updateORdelete isEqualToString:@"DELETE"]){
          
            
            collectModel *model = [array objectAtIndex:row];
            BOOL ishas = [globalHelper isExistsModel:model];
            if (ishas){
                
                
                 [globalHelper deleteToDB:model];
            }
            
            
        }
        
        
        
    }];
    
    
}



@end
