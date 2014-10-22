//
//  SizeFit.m
//  北大爱思唯尔
//
//  Created by 周武德 on 14-9-22.
//  Copyright (c) 2014年 www.healthedu.cn 北大爱思唯尔教育. All rights reserved.
//

#import "SizeFit.h"

@implementation SizeFit

static SizeFit *fitSize=nil;

+(SizeFit *)Manager{
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        fitSize = [[[self class] alloc] init];
    });
    
    
    
    return fitSize;
}
-(void)JSONString:(NSString *)aString font:(CGFloat )fontSize  contain:(CGFloat)count{
    

    NSMutableString *s = [NSMutableString stringWithString:aString];
    //[s replaceOccurrencesOfString:@"\"" withString:@"\\\"" options:NSCaseInsensitiveSearch range:NSMakeRange(0, [s length])];
    //[s replaceOccurrencesOfString:@"/" withString:@"\\/" options:NSCaseInsensitiveSearch range:NSMakeRange(0, [s length])];
   
    [s stringByReplacingOccurrencesOfString:@"\r" withString:@""];
    [s stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    [s replaceOccurrencesOfString:@"\n" withString:@"" options:NSCaseInsensitiveSearch range:NSMakeRange(0, [s length])];
    [s replaceOccurrencesOfString:@"\b" withString:@"" options:NSCaseInsensitiveSearch range:NSMakeRange(0, [s length])];
    [s replaceOccurrencesOfString:@"\f" withString:@"" options:NSCaseInsensitiveSearch range:NSMakeRange(0, [s length])];
    [s replaceOccurrencesOfString:@"\r" withString:@"" options:NSCaseInsensitiveSearch range:NSMakeRange(0, [s length])];
    [s replaceOccurrencesOfString:@"\t" withString:@"" options:NSCaseInsensitiveSearch range:NSMakeRange(0, [s length])];
    [s replaceOccurrencesOfString:@" " withString:@"" options:NSCaseInsensitiveSearch range:NSMakeRange(0, [s length])];
    [s replaceOccurrencesOfString:@"。。" withString:@"。" options:NSCaseInsensitiveSearch range:NSMakeRange(0, [s length])];
    NSArray *array = [s componentsSeparatedByString:@"\r\n"];
    NSString *string = [array componentsJoinedByString:@""];
    s = [NSMutableString stringWithString:string];
    NSLog(@"~~~~!!!!!!%@",s);
    self.returnString = s;
    [self operation:s font:fontSize contain:count];
    

}
-(void)operation:(NSString *)string font:(CGFloat)fontSize contain:(CGFloat)count{
    if (IOSVerSion){
    
    CGSize size = [string boundingRectWithSize:CGSizeMake(count, 3000) options:NSStringDrawingUsesFontLeading|NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont  systemFontOfSize:fontSize]} context:nil].size;
    self.size = size;
    }else{
    CGSize    size = [string sizeWithFont:[UIFont systemFontOfSize:fontSize] constrainedToSize:CGSizeMake(count, 3000) lineBreakMode:NSLineBreakByWordWrapping];
    }
    
    
}

@end
