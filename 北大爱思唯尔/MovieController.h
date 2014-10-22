//
//  MovieController.h
//  北大爱思唯尔
//
//  Created by 倒霉熊丶 on 14-7-9.
//  Copyright (c) 2014年 www.healthedu.cn 北大爱思唯尔教育. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MediaPlayer/MediaPlayer.h>
@class RemoteModel;
@class DetailModel;
@class personalCenterModel;
@interface MovieController : MPMoviePlayerViewController
{
    MPMoviePlayerController *_mp;
}
@property(nonatomic,strong)RemoteModel *model;
@property(nonatomic,strong)DetailModel *model1;
@property(nonatomic,strong)personalCenterModel *model2;
@property(nonatomic,assign)NSInteger num;
@end
