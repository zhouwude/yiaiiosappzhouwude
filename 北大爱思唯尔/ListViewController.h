//
//  ListViewController.h
//  北大爱思唯尔
//
//  Created by 倒霉熊丶 on 14-7-15.
//  Copyright (c) 2014年 www.healthedu.cn 北大爱思唯尔教育. All rights reserved.
//

#import "ZCFBaseViewController.h"
#import "DetailModel.h"
#import "RemoteModel.h"
#import "MiddleView.h"
#import "playView.h"
#import "TapImageView.h"
#import "UMSocial.h"
@class UMSocialDataService;
@class personalCenterModel;
@class contentView;
@interface ListViewController : ZCFBaseViewController<IamgeDelegate,UMSocialUIDelegate,UIAlertViewDelegate>
{
    UIImageView *headelView;
    UIImageView *miniViewl;
    UILabel *label1;
    UILabel *label2;
    UILabel *label3;
    UILabel *label4;
    MiddleView *_MiddleView;
    playView *play_View;
    contentView *conView;
    UIScrollView *rightSc;
    
}

@property(nonatomic,assign)BOOL enterSelect;

//@property(nonatomic,strong)NSMutableArray *dataArray;
@property(nonatomic,strong)RemoteModel *model;
@property(nonatomic,strong)DetailModel *model1;
@property(nonatomic,strong)personalCenterModel *model2;
@property(nonatomic,assign)NSInteger num;
@property(nonatomic,strong)NSArray *correlationArray;
@property(nonatomic,strong)NSString *pID;

@end
