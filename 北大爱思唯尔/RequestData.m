//
//  RequestData.m
//  北大爱思唯尔
//
//  Created by me2 on 14-8-26.
//  Copyright (c) 2014年 www.healthedu.cn 北大爱思唯尔教育. All rights reserved.
//

#import "RequestData.h"
#import "SXJDataService.h"
#import "EveryUrl.h"
#import "RemoteModel.h"
@implementation RequestData
static RequestData *dataManager = nil;




+(RequestData *)shareManager{
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        dataManager = [[[self class] alloc] init];
        
    });
    
    return dataManager;
}

-(void)number:(NSInteger)row remoteMenu:(RemoteMenu *)menu{
    self.dataArray = [[NSMutableArray alloc] init];
   NSString *str =  [EveryUrl returntring:row];
    [SXJDataService requestURL:str method:@"GET" params:nil completion:^(id result) {
        
        //DLog(@"result : %@", result);
        if ([result count] == 1&&[[result firstObject] isKindOfClass:[NSString class]]){
            menu.UrlData = nil;
        }else {
        
        for (NSDictionary *dic in result){
            
            
            RemoteModel *model = [[RemoteModel alloc] initWithContent:dic];
            [self.dataArray addObject:model];
           // NSLog(@"!!!%@",model.id);
            
            }
           
        menu.UrlData = self.dataArray;
        //NSLog(@"%d",self.dataArray.count);
        //NSLog(@"%d",menu.UrlData.count);
        }
        

       
    } error:^(id error) {
        NSLog(@"列表请求错误");
    }];


    
}

@end
