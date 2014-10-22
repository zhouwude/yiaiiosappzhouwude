//
//  MovieController.m
//  北大爱思唯尔
//
//  Created by 倒霉熊丶 on 14-7-9.
//  Copyright (c) 2014年 www.healthedu.cn 北大爱思唯尔教育. All rights reserved.
//

#import "MovieController.h"
#import <AVFoundation/AVFoundation.h>
#import "RemoteModel.h"
#import "personalCenterModel.h"
#import "DetailModel.h"
@implementation MovieController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        //NSLog(@"aaaaa");
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    
    
    //NSLog(@"啦啦啦");
    UIView *mpView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 280)];
    [self.view addSubview:mpView];
    mpView.backgroundColor = [UIColor redColor];
    
    // 流媒体地址
    
   
    NSURL *url = [NSURL URLWithString:@"http://helishi.u.qiniudn.com/kouqiang.m3u8"];
    //http://vf1.mtime.cn/Video/2012/04/23/mp4/120423212602431929.mp4
    
    //
    
    NSDictionary *opts = [NSDictionary dictionaryWithObject:[NSNumber numberWithBool:NO]
                                                     forKey:AVURLAssetPreferPreciseDurationAndTimingKey];
    AVURLAsset *urlAsset = [AVURLAsset URLAssetWithURL:url options:opts];  // 初始化视频媒体文件
    long long minute = 0, second = 0;
    second = urlAsset.duration.value / urlAsset.duration.timescale; // 获取视频总时长,单位秒
    NSLog(@"movie duration : %lld", second);
    if (second >= 60) {
        long long index = second / 60;
        minute = index;
        //second = second - index*60;
    }
    //获得视频的长度
    NSLog(@"~~~~~))))%lld",minute);
    
    //    // 创建播放器
    _mp = [[MPMoviePlayerController alloc] initWithContentURL:url];
    
    // 设置风格，没有风格，就没有控件，这个是我们自定义基础
    _mp.controlStyle = MPMovieControlStyleDefault;
    //_mp.view.backgroundColor = [UIColor redColor];
    // 控件嵌入式.  控件全屏播放
    // label,silder,button 加到mp.view
    
    // 设置比例
    _mp.scalingMode = MPMovieScalingModeAspectFit;
    
    // 播放状态
    //    if (mp.playbackState == MPMoviePlaybackStatePlaying)
    //    {
    //
    //    }
    //    MPMoviePlaybackStateStopped,  动画播放停止状态，
    //    MPMoviePlaybackStatePlaying,  动画播放状态播放，
    //    MPMoviePlaybackStatePaused,   动画播放暂停状态，
    //    MPMoviePlaybackStateInterrupted,      动画播放状态打断，
    //    MPMoviePlaybackStateSeekingForward,   电影播放状态求进，
    //    MPMoviePlaybackStateSeekingBackward   电影播放状态向后求
    
    _mp.view.frame = CGRectMake(0, 0, 320, 280);
    [mpView addSubview:_mp.view];
    
    [_mp play];
    //NSLog(@"!!!!!%f",_mp.duration);
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(moviePlayerChange:) name:MPMoviePlayerPlaybackStateDidChangeNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(moviePlayerDuration:) name:MPMovieDurationAvailableNotification object:nil];
    
    // 添加通知，观察视频播放的变化
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(moviePlayerDidFinish:) name:MPMoviePlayerPlaybackDidFinishNotification object:nil];
    
    // 添加通知，观察视频播放的变化
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(moviePlayerLoad:) name:MPMoviePlayerLoadStateDidChangeNotification object:nil];
}
-(void)moviePlayerDuration:(NSNotification *)notification{
    
    NSLog(@"duration : %.1f", self.moviePlayer.duration);
    NSLog(@"duration : %.1f", self.moviePlayer.playableDuration);

    
}

- (void)moviePlayerChange:(NSNotification *)notification
{
    MPMoviePlayerController *mp = [notification object];
    // 播放器的状态
    NSLog(@"object : %d", mp.playbackState);
    NSLog(@"duration : %f", mp.currentPlaybackTime);

}// 播放的状态改变

- (void)moviePlayerDidFinish:(NSNotification *)notification
{
    MPMoviePlayerController *mp = [notification object];

    NSLog(@"moviePlayerDidFinish");
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
    NSLog(@"Current duration : %f", mp.currentPlaybackTime);
    [self getUrl:mp.currentPlaybackTime];

}// 播放结束
-(void)getUrl:(double)time{
    if (time>60*3){
       // http://kouqiang.yiaiwang.com.cn/index.php?r=cme2014/api/Setscanhistory&userid=316&prjid=2070&courseid=5832&typeid=1618
       [MkNetWorkParse requestData:[NSString stringWithFormat:@"index.php?r=cme2014/api/Setscanhistory&userid=%@&prjid=%@&courseid=%@&typeid=%@",DEFAULT(USERID),_model.cate_id,_num!=1000?_model.RemoteModelID:_model2.model.personalCenterModelID,@"1618"] Method:@"GET" success:^(id JSON) {
           
           NSLog(@"~~~~~~%@",JSON);
           
            
        } fail:^(NSError *error, id JSON) {
            
        }];
        
        
        
        
        
    }else{
        return;
    }
    
    
    
}

- (void)moviePlayerLoad:(NSNotification *)notification
{
    // 视频总时长
    MPMoviePlayerController *mp = [notification object];

    NSLog(@"total duration : %.1f", mp.duration);
    NSLog(@"duration : %.1f", mp.playableDuration);

    
    // 加载的状态
    NSLog(@"loadState : %d",mp.loadState);
    
}// 加载状态




- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
}

@end
