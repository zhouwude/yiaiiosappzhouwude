//
//  ListViewController.m
//  北大爱思唯尔
//
//  Created by 倒霉熊丶 on 14-7-15.
//  Copyright (c) 2014年 www.healthedu.cn 北大爱思唯尔教育. All rights reserved.
//

#import "ListViewController.h"
#import "CustomCell.h"

#import "SXJDataService.h"
#import "DetailModel.h"
#import "personalCenterModel.h"
#import "UIViewExt.h"
#import "shareView.h"
#import "topicViewController.h"
#import "contentView.h"
#import "MovieViewController.h"
#import "collectMetod.h"
#import "MovieController.h"

@interface ListViewController (){
    UIAlertView *warnView;
    UIAlertView *warnView1;

    UIButton *buttonEnter;
}


@end

@implementation ListViewController
@synthesize enterSelect;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title  = @"课程详情";
        enterSelect = 1;
            }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    //self.navigationController.navigationBar.translucent = NO;
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self createUI];
    //[self BrowseCourse];
   
    [self createData];
    [self BrowseCourse];

    
    
}
-(void)BrowseCourse{
    NSString *str = nil;
    if (_num == 3112||_num==3111){
        str = _num==3111?self.model2.personalCenterModelID :self.model2.model.personalCenterModelID;
    }else{
        str = self.model.RemoteModelID;
    }


    NSString *pathStr = [NSString stringWithFormat:@"index.php?r=cme2014/api/Setlearnrecord&userid=%@&prjid=%@&courseid=%@&typeid=%@",DEFAULT(USERID),_model.cate_id,str,@"1618"];
    //NSLog(@"!!!!%@",pathStr);

    [MkNetWorkParse requestData:pathStr Method:@"GET" success:^(id JSON) {
        NSLog(@"~~~~~%@！！！",JSON);
        
        
        
        
    } fail:^(NSError *error, id JSON) {
        
        
        
    }];
    
    
    
    
    
}

-(void)createUI{
    rightSc = [[UIScrollView alloc] initWithFrame:CGRectMake(125,10 ,kScreenWidth-125 , 140)];
    rightSc.showsHorizontalScrollIndicator = NO;
    rightSc.bounces = NO;
    [self.view addSubview:rightSc];
    headelView = [[UIImageView alloc] init];
    [self.view addSubview:headelView];
    label1 = [[UILabel alloc] init];
    label1.preferredMaxLayoutWidth = kScreenWidth-130;
    label1.translatesAutoresizingMaskIntoConstraints = NO;
    label1.numberOfLines = 0;
    [rightSc addSubview:label1];
    label2 = [[UILabel alloc] init];
    label2.translatesAutoresizingMaskIntoConstraints = NO;
    label2.numberOfLines = 0;
    label2.preferredMaxLayoutWidth = kScreenWidth-130;
    buttonEnter = [[UIButton alloc] init];
    buttonEnter.translatesAutoresizingMaskIntoConstraints = NO;
    [rightSc addSubview:buttonEnter];
    [rightSc addSubview:label2];
    label3 = [[UILabel alloc] init];
    label3.translatesAutoresizingMaskIntoConstraints = NO;
    label3.numberOfLines = 0;
    label3.preferredMaxLayoutWidth = kScreenWidth-130;

    [rightSc addSubview:label3];
    label4 = [[UILabel alloc] init];
    [rightSc addSubview:label4];
    [self createResize];
    //play_View = [[playView alloc] init];
   // play_View.translatesAutoresizingMaskIntoConstraints = NO;
    
    [rightSc addSubview:play_View];
    _MiddleView = [[MiddleView alloc] initWithFrame:CGRectMake(0, headelView.bottom+5, kScreenWidth, 49)];
    //play_View.parent = self;
    _MiddleView.parent = self;
    [self.view addSubview:_MiddleView];
    
    
    shareView *view = [[shareView alloc] initWithFrame:CGRectMake(0, kScreenHeight-50-64, kScreenWidth, 50)];
    view.shareBlock = ^(NSInteger num){
        [self createShare:num];
    };
    //view.backgroundColor = [UIColor redColor];
    [self.view addSubview:view];
   
    conView = [[contentView alloc] initWithFrame:CGRectMake(0,_MiddleView.bottom,kScreenWidth , view.top-_MiddleView.bottom)];
    conView.parent = self;
    [self.view addSubview:conView];
    conView.dataArray = _correlationArray;
}
-(void)test{
    self.enterSelect = 1;
    
}
-(void)EnterStady{
    NSString *str = nil;
    
    if (_num == 3112||_num==3111){
        str = _num==3111?self.model2.personalCenterModelID :self.model2.model.personalCenterModelID;
    }else{
        str = self.model.RemoteModelID;
    }

    [MkNetWorkParse  requestData:[NSString stringWithFormat:@"/index.php?r=cme2014/api/Getquizpass&userid=%@&courseid=%@",DEFAULT(USERID),str] Method:@"GET" success:^(id JSON) {
        if ([JSON isKindOfClass:[NSArray class]]&&[[JSON firstObject] integerValue]==0){
            
            topicViewController *vc = [[topicViewController alloc] init];
            vc.title = @"答题";
            vc.parent = self;
            vc.courseID = self.model1.model.courseid;
            if (enterSelect){
                enterSelect = 0;
            [self.navigationController pushViewController:vc animated:YES];
            }
            
        }else{
            UIAlertView *view = [[UIAlertView alloc] initWithTitle:@"提示" message:@"你已经完成该课程的答题" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
            [view show];
            
            
            
        }
    } fail:^(NSError *error, id JSON) {
        
    }];


    
}

-(void)createShare:(NSInteger)num{
    if (num-100==1) {
        collectMetod *methodSS = [collectMetod manager];
        NSArray *array = [collectMetod findColumn:@"courseID"];
        if (![array containsObject:_model1.model.courseid]){
            [AppDelegate showStatusWithText:@"收藏成功" duration:2];
        [methodSS insetData:_model1];
        }else{
            [AppDelegate showStatusWithText:@"该课程你已经收藏" duration:2];
            
            
        }
        
        
        
        
    }
    if (num-100==2){
    NSLog(@"分享开始");
           [UMSocialSnsService presentSnsIconSheetView:self
                                         appKey:@"538597e956240bdc070fb81a"
                                      shareText:@"友盟社会化分享让您快速实现分享等社会化功能，www.umeng.com/social"
                                     shareImage:[UIImage imageNamed:@"icon"]
                                shareToSnsNames:[NSArray arrayWithObjects:UMShareToSina,UMShareToTencent,UMShareToRenren,UMShareToQzone,UMShareToLWSession,UMShareToQQ,nil]
                                       delegate:self];
    }
//    return;
//    
//    [[UMSocialControllerService defaultControllerService] setShareText:@"分享内嵌文字" shareImage:[UIImage imageNamed:@"Default@2x"] socialUIDelegate:self];        //设置分享内容和回调对象
//    [UMSocialSnsPlatformManager getSocialPlatformWithName:UMShareToSina].snsClickHandler(self,[UMSocialControllerService defaultControllerService],YES);
//    return;
  
    
}
-(void)didFinishGetUMSocialDataInViewController:(UMSocialResponseEntity *)response
{
    //根据`responseCode`得到发送结果,如果分享成功
    if(response.responseCode == UMSResponseCodeSuccess)
    {
        //得到分享到的微博平台名
        NSLog(@"share to sns name is %@",[[response.data allKeys] objectAtIndex:0]);
    }
}
-(BOOL)isDirectShareInIconActionSheet
{
    return YES;
}
-(void)Click:(TapImageView *)view{
    NSLog(@"~~~~~~~~~~~~~~%@",_model1.dataModel.STORAGE_PATH);
    
        if(![_model1.dataModel.STORAGE_PATH hasSuffix:@"m3u8"]){
        warnView1 = [[UIAlertView alloc] initWithTitle:@"提醒" message:@"该课程无法在iphone上播放，请选择其他设备进行播放" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [warnView1 show];
        return;
        
        
    }
    
    
    
    NSArray *array = [[NSArray alloc] initWithContentsOfFile:[homeURL stringByAppendingString:@"/course.plist"]];
    if ([array containsObject:_model1.model.courseid]){
    MovieViewController *vc = [[MovieViewController alloc] init];
        vc.URL = _model1.dataModel.STORAGE_PATH;
    [self.navigationController pushViewController:vc animated:YES];
    }else{
        
        warnView = [[UIAlertView alloc] initWithTitle:@"提醒" message:@"该课程您还没有购买，请购买后再学习" delegate:self cancelButtonTitle:@"确定购买" otherButtonTitles:@"取消", nil];
        [warnView show];
        
        
    }
//    MovieController *vc1 = [[MovieController alloc] init];
//    vc1.model = self.model;
//    vc1.model1 = self.model1;
//    vc1.model2 = self.model2;
//    vc1.num = self.num;
//    [self presentViewController:vc1 animated:YES completion:^{
//        
//    }];

    
}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (alertView == warnView){
        if (buttonIndex == 0){
            
        }else{
            
            
        }
        
        
        
    }
}
-(void)createResize{
    headelView.frame = CGRectMake(5, 10, 120, 140);
    headelView.image = [UIImage imageNamed:@"logo.png"];
    headelView.userInteractionEnabled = YES;
    miniViewl = [[UIImageView alloc] initWithFrame:CGRectMake(80,0 , 40, 40)];
    
    [headelView addSubview:miniViewl];
    miniViewl.backgroundColor = [UIColor clearColor];
    TapImageView *insetImage = [[TapImageView alloc] initWithFrame:CGRectMake(40,50 , 40, 40)];
    insetImage.parent = self;
    insetImage.image = [UIImage imageNamed:@"bfzn_004.png"];
    [headelView addSubview:insetImage];

    
    
    
    
}
-(void)configUI{
    
    if ([_model1.model.price integerValue]>0){
        
        miniViewl.image = [UIImage imageNamed:@"付费.png"];
        
    }else{
        miniViewl.image = [UIImage imageNamed:@"免费.png"];
    }
    
    label1.text =[NSString stringWithFormat:@"课程名称:%@",_model1.fullname];
    //label1.font = [UIFont systemFontOfSize:15];
    label2.text = [NSString stringWithFormat:@"主讲医师:%@",_model1.speaker];
    label3.text =  [NSString stringWithFormat:@"医院:%@",_model1.speakerorg];
   
    //play_View.userInteractionEnabled = YES;
    
   // buttonEnter = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, play_View.frame.size.width, play_View.frame.size.height)];
   // [play_View addSubview:buttonEnter];
    [buttonEnter addTarget:self action:@selector(EnterStady) forControlEvents:UIControlEventTouchUpInside];
    [buttonEnter setTitleColor:[ColorUtil getColor:@"B3EE3A" alpha:1] forState:UIControlStateNormal];
    [buttonEnter setTitle:@"进入随堂测试" forState:UIControlStateNormal];
    
    //buttonEnter.translatesAutoresizingMaskIntoConstraints = NO;
    NSDictionary *views = NSDictionaryOfVariableBindings(label1,label2,label3,buttonEnter);
    [rightSc addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[label1]-5-[label2]-5-[label3]-5-[buttonEnter]-0-|" options:0 metrics:0 views:views]];
    [rightSc addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-5-[label1]-0-|" options:0 metrics:0 views:views]];
    [rightSc addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-5-[label2]-0-|" options:0 metrics:0 views:views]];

    [rightSc addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-5-[label3]-0-|" options:0 metrics:0 views:views]];
    [rightSc addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-5-[buttonEnter]" options:0 metrics:0 views:views]];

   
}
-(void)createData{
    NSString *str = nil;
    
    if (_num == 3112||_num==3111){
        str = [NSString stringWithFormat:@"?r=cme2014/api/Getcourse&course_id=%@",_num==3111?self.model2.personalCenterModelID :self.model2.model.personalCenterModelID];
    }else{
        str = [NSString stringWithFormat:@"?r=cme2014/api/Getcourse&course_id=%@",self.model.RemoteModelID];
    }
    NSString *str1 = nil;
    if (_num == 3112||_num==3111){
       // str = [NSString stringWithFormat:@"?r=cme2014/api/Getcourse&course_id=%@",_num==3111?self.model2.personalCenterModelID :self.model2.model.personalCenterModelID];
    }else{
        str1 = [NSString stringWithFormat:@"%@",self.model.cate_name];
        
        
    }

    
    [SXJDataService requestURL:str method:@"GET" params:nil completion:^(id result) {
        //NSLog(@"%@!!!!!",result);
        DetailModel *model = [[DetailModel alloc] initWithContent:result];
        if (_model1!=nil){
            _model1 = nil;
        }
        
        self.model1 = model;

        [self configUI];
        [conView configUI:_model1 array:_correlationArray contactData:str1];
        
    } error:^(id error) {
        
        NSLog(@"%@",error);
        
        
        
    }];
    
    
    
    
    
    
    
    
    
}
-(void)loadData:(RemoteModel *)model{
    
    self.model = model;
    
    
    [self BrowseCourse];
    [self createData];
    
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];

}



#pragma mark - TableView DataSource

@end
