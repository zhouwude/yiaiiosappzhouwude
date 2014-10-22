
//
//  HttpDownLoadBlock.m
//  HttpRequestDemo_1409
//
//  Created by ZhangCheng on 14-5-20.
//  Copyright (c) 2014年 张诚. All rights reserved.
//

#import "HttpDownLoadBlock.h"
#import "MyMD5.h"
#import "NSFileManager+method.h"
#import "MMProgressHUD.h"
@implementation HttpDownLoadBlock
-(id)initWithUrlStr:(NSString*)urlStr setBlock:(void(^)(HttpDownLoadBlock*,BOOL))a{
    if (self=[super init]) {
        self.data=[NSMutableData dataWithCapacity:0];
        self.httpRequestBlock=a;
        //显示网络HUD指示器
        //[self startHUDshow];
        //设置网络请求
        [self httpRequest:urlStr];
    }
    return self;
}
#pragma mark 取消请求
-(void)cancelBlock{
    if (_connection) {
        [_connection cancel];
        [_connection release];
        _connection=nil;
    }
}

//进行网络请求
-(void)httpRequest:(NSString*)urlStr{
    //使用MD5进行加密
    self.pathFile=[NSString stringWithFormat:@"%@/Documents/%@",NSHomeDirectory(),[MyMD5 md5:urlStr]];
    NSFileManager*manager=[NSFileManager defaultManager];
    
    //fileExistsAtPath 判断文件或者文件夹是否存在
    if ([manager fileExistsAtPath:self.pathFile]&&[manager timeOutWithPath:self.pathFile timeOut:60*60]) {
        //缓存目录是有效的
        self.data = [NSData dataWithContentsOfFile:self.pathFile];
        [self jsonValue]; 
        //显示请求成功
        [self loadHUDisFinishOrFail:YES];
        
        if (self.httpRequestBlock) {
            
             self.httpRequestBlock(self,YES);
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
    //显示请求成功
    [self loadHUDisFinishOrFail:YES];
    
    if (self.data.length>0) {
        [self.data writeToFile:self.pathFile atomically:YES];
        [self jsonValue];
        if (self.httpRequestBlock) {
            
            self.httpRequestBlock(self,YES);
        }
    }else{
        if (self.httpRequestBlock) {
            
            self.httpRequestBlock(self,NO);
        }
    }
    
    
   
   

    
}
-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    //显示请求失败
    [self loadHUDisFinishOrFail:NO];
    
    if (self.httpRequestBlock) {
        
        self.httpRequestBlock(self,NO);
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
#pragma mark 开始请求的指示器
-(void)startHUDshow{
    //系统状态条的菊花显示
    [UIApplication sharedApplication].networkActivityIndicatorVisible=YES;
[MMProgressHUD showWithTitle:@"网络请求" status:@"疯狂加载中。。。。" cancelBlock:^{
    
    [UIApplication  sharedApplication].networkActivityIndicatorVisible=NO;
    //当点击取消时候会触发block回调
    [self cancelBlock];
    //显示请求失败
    [self loadHUDisFinishOrFail:NO];
}];

}
#pragma mark 请求成功与失败的指示器
-(void)loadHUDisFinishOrFail:(BOOL)isFinish{
    //无论请求成功与失败，都需要关闭系统状态条菊花
    [UIApplication  sharedApplication].networkActivityIndicatorVisible=NO;
    
    if (isFinish) {
        [MMProgressHUD dismissWithSuccess:@"请求成功"];
    }else{
        [MMProgressHUD dismissWithError:@"网络错误"];
    }


}




@end
