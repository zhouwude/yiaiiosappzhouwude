//
//  HttpDownLoad.m
//  HttpRequestDemo_1409
//
//  Created by ZhangCheng on 14-5-20.
//  Copyright (c) 2014年 张诚. All rights reserved.
//

#import "HttpDownLoad.h"
#import "MyMD5.h"
#import "NSFileManager+method.h"
@implementation HttpDownLoad
-(id)initWithUrlStr:(NSString*)urlStr setDelegate:(id)target{
    if (self=[super init]) {
        self.data=[NSMutableData dataWithCapacity:0];
        self.delegate=target;
        //设置网络请求
        [self httpRequest:urlStr];
    }
    return self;
}
//进行网络请求
-(void)httpRequest:(NSString*)urlStr{
//使用MD5进行加密
    self.pathFile=[NSString stringWithFormat:@"%@/documents/%@",NSHomeDirectory(),[MyMD5 md5:urlStr]];
    NSFileManager*manager=[NSFileManager defaultManager];
    
    //fileExistsAtPath 判断文件或者文件夹是否存在
    if ([manager fileExistsAtPath:self.pathFile]&&[manager timeOutWithPath:self.pathFile timeOut:60*60]) {
        //缓存目录是有效的
        self.data=[NSData dataWithContentsOfFile:self.pathFile];
        [self jsonValue];
        
        if ([_delegate respondsToSelector:@selector(httpRequestFinishOrFail:isFinish:)]) {
            [_delegate httpRequestFinishOrFail:self isFinish:YES];
        }
    }else{
        self.connection=[NSURLConnection connectionWithRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:urlStr]] delegate:self];
    
    }
}
#pragma mark 4个网络请求的代理方法
-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    [self.data setLength:0];
    //self.data=[NSMutableData dataWithCapacity:0];
}

-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [self.data appendData:data];
}

-(void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    [self.data writeToFile:self.pathFile atomically:YES];
    [self jsonValue];
    if ([_delegate respondsToSelector:@selector(httpRequestFinishOrFail:isFinish:)]) {
        [_delegate httpRequestFinishOrFail:self isFinish:YES];
    }
}
-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    if ([_delegate respondsToSelector:@selector(httpRequestFinishOrFail:isFinish:)]) {
        [_delegate httpRequestFinishOrFail:self isFinish:NO];
    }
}
-(void)jsonValue{
//进行解析
    id result=[NSJSONSerialization JSONObjectWithData:self.data options:NSJSONReadingMutableContainers error:nil];
    if ([result isKindOfClass:[NSArray class]]) {
        //是数组
        self.dataArray=[NSArray arrayWithArray:result];
    }else{
    
        if ([result isKindOfClass:[NSDictionary class]]) {
            self.dataDict=[NSDictionary dictionaryWithDictionary:result];
        }else{
            self.dataImage=[UIImage imageWithData:self.data];
        }
    }
    

}
@end
