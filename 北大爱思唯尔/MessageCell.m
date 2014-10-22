//
//  MessageCell.m
//  北大爱思唯尔
//
//  Created by me2 on 14-9-3.
//  Copyright (c) 2014年 www.healthedu.cn 北大爱思唯尔教育. All rights reserved.
//

#import "MessageCell.h"
#import "ColorUtil.h"
#import "MKNetworkKit.h"
@implementation MessageCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self createUI];
    }
    return self;
}

- (void)awakeFromNib
{
    // Initialization code
}

-(void)createUI{
    
    messageLabel = [[UILabel alloc] init];
    messageLabel.translatesAutoresizingMaskIntoConstraints =NO;
    messageLabel.numberOfLines = 0;
    [self.contentView addSubview:messageLabel];
    NSDictionary *views =  NSDictionaryOfVariableBindings(messageLabel,self.contentView);
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-10-[messageLabel]-10-|" options:0 metrics:0 views:views]];
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-20-[messageLabel]" options:0 metrics:0 views:views]];

    
    
    
}
-(void)reQuest{
    MKNetworkEngine *engine = [[MKNetworkEngine alloc] initWithHostName:@"kouqiang.yiaiwang.com.cn" customHeaderFields:nil];
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [dic setValue:@"cme2014/api/updateuserinfo" forKey:@"r"];
    [dic setValue:[[NSUserDefaults standardUserDefaults] objectForKey:USERID] forKey:@"uid"];
    [dic setValue:_dataArray forKey:@"content"];
    
    MKNetworkOperation *op = [engine operationWithPath:@"/index.php" params:dic httpMethod:@"POST"];
    [op addCompletionHandler:^(MKNetworkOperation *operation) {
        NSLog(@"[operation responseData]-->>%@", [operation responseString]);
    }errorHandler:^(MKNetworkOperation *errorOp, NSError* err) {
        NSLog(@"MKNetwork request error : %@", [err localizedDescription]);
    }];
    [engine enqueueOperation:op];
    
    
    
}
-(MKNetworkOperation*) downloadFatAssFileFrom:(NSString*) remoteURL toFile:(NSString*) filePath {
    MKNetworkEngine *engine = [[MKNetworkEngine alloc] initWithHostName:@"imgcache.qq.com" customHeaderFields:nil];
     MKNetworkOperation *op = [engine operationWithPath:remoteURL params:nil httpMethod:@"GET"];
    [op addDownloadStream:[NSOutputStream outputStreamToFileAtPath:filePath
                                                            append:YES]];
    [engine enqueueOperation:op];
    return op;
}
-(void)testDownload{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *cachesDirectory = [paths objectAtIndex:0];
    NSString *downloadPath = [cachesDirectory stringByAppendingPathComponent:@"DownloadedFile.zip"];
    
    MKNetworkOperation *downloadOperation=[self downloadFatAssFileFrom:@"/club/item/theme/zip/0/i1100/1100_2.zip"
                                                                       toFile:downloadPath];
    
    [downloadOperation onDownloadProgressChanged:^(double progress) {
        //下载进度
        NSLog(@"download progress: %.2f", progress*100.0);
    }];
    //事件处理
    [downloadOperation addCompletionHandler:^(MKNetworkOperation* completedRequest) {
        NSLog(@"download file finished!");
    }  errorHandler:^(MKNetworkOperation *errorOp, NSError* err) {
        NSLog(@"download file error: %@", err);
    }];
}

-(void)conFig:(NSString *)str{
    messageLabel.text = str;
        
    
    
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
