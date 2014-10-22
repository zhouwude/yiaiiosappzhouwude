//
//  EveryUrl.m
//  北大爱思唯尔
//
//  Created by me2 on 14-8-26.
//  Copyright (c) 2014年 www.healthedu.cn 北大爱思唯尔教育. All rights reserved.
//

#import "EveryUrl.h"

@implementation EveryUrl
+(NSString *)returntring:(NSInteger)number{
    
    if (number == Implantology){
        return [NSString stringWithFormat:@"?r=cme2014/api/geteducationlist&str=%@",@"implantology"];
        
    }
    
    if (number == Nurse){
        return [NSString stringWithFormat:@"?r=cme2014/api/geteducationlist&str=%@",@"nurse"];
        
    }
    if (number == Manage){
        return [NSString stringWithFormat:@"?r=cme2014/api/geteducationlist&str=%@",@"manage"];
        
    }
    if (number == Cmecourse){
        return [NSString stringWithFormat:@"?r=cme2014/api/geteducationlist&str=%@",@"cmecourse"];
        
    }
    if (number == Enterprise){
        return [NSString stringWithFormat:@"?r=cme2014/api/geteducationlist&str=%@",@"enterprise"];
        
    }
    if (number == Online){
        return [NSString stringWithFormat:@"?r=cme2014/api/geteducationlist&str=%@",@"online"];
        
    }
    return nil;
    
    
    
    
}

@end
