//
//  topicViewController.m
//  北大爱思唯尔
//
//  Created by me2 on 14-9-9.
//  Copyright (c) 2014年 www.healthedu.cn 北大爱思唯尔教育. All rights reserved.
//

#import "topicViewController.h"
#import "topicView.h"
#import "MKNetworkKit.h"
#import "QuestionModel.h"
#import "JSONKit.h"
#import "SizeFit.h"
#import "SXJDataService.h"
@interface topicViewController (){
    topicView *view;
    UIAlertView *view2;
}

@property(nonatomic,strong)NSArray *titleArray;
@property(nonatomic,assign)BOOL animating;
@end

@implementation topicViewController
@synthesize enterSelect;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
        page = 0;
        enterSelect = 1;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    //self.navigationController.navigationBar.translucent = NO;
    tempPage = 100;
    self.dataArray = [[NSMutableArray array] init];
    self.tempDict =  [[NSMutableDictionary alloc] init];
    self.resultDict = [[NSMutableDictionary alloc] init];
    self.tagArray = [[NSMutableArray alloc] init];
    if (_courseID&&_courseID.length>0){
    [_resultDict setObject:_courseID forKey:@"courseid"];
    }
    [_resultDict setObject:[[NSUserDefaults standardUserDefaults] objectForKey:USERID] forKey:@"id"];
    self.view.backgroundColor = [UIColor whiteColor];
    [self createNai];
    
    [self createData];
   
}
-(void)createNai{
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 40, 30)];
    [button setTitle:@"提交" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(buttonClickCommit) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *itemButton = [[UIBarButtonItem alloc] initWithCustomView:button];
    self.navigationItem.rightBarButtonItem = itemButton;
    
    
    
    
    
}
-(void)buttonClickCommit{
    

    for (id objc in _resultDict.allValues){
        if ([objc isKindOfClass:[NSArray class]]){
            NSArray *tempArray = objc;
            NSLog(@"~!~!~!~!~!~!~%d",tempArray.count);
        
        if (tempArray.count==0){
            
            UIAlertView *view4 = [[UIAlertView alloc] initWithTitle:@"提醒" message:@"还有题未完成" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
            [view4 show];
  
            return;
        }
            
        }
    }
      
    if (_resultDict.count==_dataArray.count+2){
        
        
        
        NSArray *path=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
        NSString *pathStr = [path objectAtIndex:0];
        [_resultDict writeToFile:[pathStr stringByAppendingString:@"/Dict.plist"] atomically:YES];
        view2 = [[UIAlertView alloc] initWithTitle:@"提醒" message:@"是否要提交？" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:@"取消",nil];
        [view2 show];
      
        
//        NSString *str = nil;
//        str = [_resultDict JSONString];
//        [SXJDataService requestURL:[NSString stringWithFormat:@"?r=cme2014/api/Setquiz&data=%@",str] method:@"GET" params:nil completion:^(id result) {
//            NSLog(@"!!!!!!!%@",result);
//        } error:^(id error) {
//            
//        }];

    }else {
        
        UIAlertView *view3 = [[UIAlertView alloc] initWithTitle:@"提醒" message:@"还有题未完成，请答完再提交。" delegate:self cancelButtonTitle:@"继续答题" otherButtonTitles:nil];
        [view3 show];
        
        
        
    }

    
    
    
    
}
-(NSString *)JSONString:(NSString *)aString {
    NSMutableString *s = [NSMutableString stringWithString:aString];
   
    [s replaceOccurrencesOfString:@"\n" withString:@"\\n" options:NSCaseInsensitiveSearch range:NSMakeRange(0, [s length])];
    [s replaceOccurrencesOfString:@"\b" withString:@"\\b" options:NSCaseInsensitiveSearch range:NSMakeRange(0, [s length])];
    [s replaceOccurrencesOfString:@"\f" withString:@"\\f" options:NSCaseInsensitiveSearch range:NSMakeRange(0, [s length])];
    [s replaceOccurrencesOfString:@"\r" withString:@"\\r" options:NSCaseInsensitiveSearch range:NSMakeRange(0, [s length])];
    [s replaceOccurrencesOfString:@"\t" withString:@"\\t" options:NSCaseInsensitiveSearch range:NSMakeRange(0, [s length])];
    return [NSString stringWithString:s];
}
-(void)viewDidAppear:(BOOL)animated{
    [self test];
}
-(void)test{
    if ([_parent respondsToSelector:@selector(test)]){
        [_parent performSelector:@selector(test)];
    }
}
-(void)createUI{
    label = [[UILabel alloc] initWithFrame:CGRectMake(20, 20, 200, 30)];
    label.text = [NSString stringWithFormat:@"题目:%d/%d",page+1,_dataArray.count];
    label.font = [UIFont systemFontOfSize:20];
    label.textColor = [ColorUtil getColor:@"B3EE3A" alpha:1];
    [self.view addSubview:label];

    view = [[topicView alloc] initWithFrame:CGRectMake(0, 55, kScreenWidth, kScreenHeight-kNavgationHeight-kStatusHeight-55)];
     [view createSomeUI:self.dataArray[page] count:page];
    view.allCount = self.dataArray.count;
    //view.translatesAutoresizingMaskIntoConstraints = NO;
    
    view.parent = self;
    [self.view addSubview:view];
//   NSDictionary *views = NSDictionaryOfVariableBindings(view);
//    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-55-[view]" options:0 metrics:0 views:views]];
//    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-0-[view]-0-|" options:0 metrics:0 views:views]];
    //[view createSomeUI:self.dataArray[page] count:page];
    

    

    

    
    
    
}
-(void)Click:(TapImageView *)view1{
    NSInteger  QuestionNum = view1.tag-100;
    NSLog(@"~!~!~~!!~%d",QuestionNum);
    QuestionModel *model= [_dataArray objectAtIndex:page];
    
    if (tempPage !=page){
        tempPage = page;
        array = [[NSMutableArray array] init];
        
    }
    
    
    
    switch (view1.tag-100) {
        case 0:
            isSelect = !isSelect;
            if (isSelect){
                
                view1.image = [UIImage imageNamed:@"1_03.png"];
                QuestionModel *model1 = model.dataArray[QuestionNum];
                
                [array addObject:model1.ID];
                [_resultDict setObject:array forKey:model.ID];
                
            }else{
                view1.image = [UIImage imageNamed:@"1_06.jpg"];
                QuestionModel *model1 = model.dataArray[QuestionNum];
                
                [array removeObject:model1.ID];
                [_resultDict setObject:array forKey:model.ID];
                
            }

            
            break;
        case 1:
            isSelect1 = !isSelect1;
            if (isSelect1){
                view1.image = [UIImage imageNamed:@"1_03.png"];
                QuestionModel *model1 = model.dataArray[QuestionNum];
                
                [array addObject:model1.ID];
                [_resultDict setObject:array forKey:model.ID];
                
            }else{
                view1.image = [UIImage imageNamed:@"1_06.jpg"];
                QuestionModel *model1 = model.dataArray[QuestionNum];
                
                [array removeObject:model1.ID];
                [_resultDict setObject:array forKey:model.ID];
                
            }
            
            
            break;
        case 2:
            isSelect2 = !isSelect2;
            if (isSelect2){
                view1.image = [UIImage imageNamed:@"1_03.png"];
                QuestionModel *model1 = model.dataArray[QuestionNum];
                
                [array addObject:model1.ID];
                [_resultDict setObject:array forKey:model.ID];
                
                
                
            }else{
                view1.image = [UIImage imageNamed:@"1_06.jpg"];
                QuestionModel *model1 = model.dataArray[QuestionNum];
                
                [array removeObject:model1.ID];
                [_resultDict setObject:array forKey:model.ID];

            }
            
            break;
        case 3:
            isSelect3 = !isSelect3;
            if (isSelect3){
                view1.image = [UIImage imageNamed:@"1_03.png"];
                QuestionModel *model1 = model.dataArray[QuestionNum];
                
                [array addObject:model1.ID];
                [_resultDict setObject:array forKey:model.ID];
                
            }else{
                view1.image = [UIImage imageNamed:@"1_06.jpg"];
                QuestionModel *model1 = model.dataArray[QuestionNum];
                
                [array removeObject:model1.ID];
                [_resultDict setObject:array forKey:model.ID];

            }
            
            break;
            
        default:
            break;
    }
    
    
    NSLog(@"!~!~!~!~%@",_resultDict);
    
    
    
}

-(void)backButtonClick{
    if (page>0){
        isSelect = 0;
        isSelect1 = 0;

        isSelect2 = 0;

        isSelect3= 0;

        page-=1;
        
        
        [view createSomeUI:_dataArray[page] count:page];
        label.text = [NSString stringWithFormat:@"题目:%d/%d",page+1,_dataArray.count];
        
        
 
        
    }
    
    
    
    
}
-(void)buttonClick {
    if (page<_dataArray.count-1){
        isSelect = 0;
        isSelect1 = 0;
        
        isSelect2 = 0;
        
        isSelect3= 0;
    
    page +=1;
    [view createSomeUI:_dataArray[page] count:page];
    label.text = [NSString stringWithFormat:@"题目:%d/%d",page+1,_dataArray.count];
    
    
    }
   
    
    
    
    
    
    
        
    
        
    
    
}



-(void)createData{
    

        
    [MkNetWorkParse requestData:[NSString stringWithFormat:@"index.php?r=cme2014/api/Getquizbycourseid&courseid=%@&userid=%@",_courseID,DEFAULT(USERID)] Method:@"GET"success:^(id JSON) {
        NSArray *arrayData = JSON;
       //NSLog(@"~~~~~~~%@",array);
        if (arrayData.count==1){
            alert = [[UIAlertView alloc] initWithTitle:@"提醒" message:@"暂时还没有改课程的相关试题" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
            [alert show];
            
            }else{
                
                self.dataArray = [[NSMutableArray alloc] init];
                for (NSDictionary *dict in JSON){
                    QuestionModel *model = [[QuestionModel alloc] initWithContent:dict];
                    [self.dataArray addObject:model];
                    
                }
            
            
             [self createUI];
            
            
        }
                
        
        
    } fail:^(NSError *error, id JSON) {
        
    }];
    
    
    

    
}


-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (alertView == view2){
        if(buttonIndex==0){
        
        NSString *str = nil;
        str = [_resultDict JSONString];
        [SXJDataService requestURL:[NSString stringWithFormat:@"?r=cme2014/api/Setquiz&data=%@",str] method:@"GET" params:nil completion:^(id result) {
            NSLog(@"!!!!!!!%@",result);
        } error:^(id error) {
            
        }];
        }else{
            
        }

        
        
        
    }
    
    if (alert==alertView){
    if (buttonIndex == 0){
        
        
        [self.navigationController popViewControllerAnimated:YES];
        
    }
    }
    
    
    
}
    
    




- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
