//
//  CentreViewController.h
//  北大爱思唯尔
//
//  Created by 倒霉熊丶 on 14-8-1.
//  Copyright (c) 2014年 www.healthedu.cn 北大爱思唯尔教育. All rights reserved.
//

#import "ZCFBaseViewController.h"

@interface CentreViewController : ZCFBaseViewController <UITableViewDelegate,UITableViewDataSource,UIAlertViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>{
    NSInteger selectIndex;
    NSArray *MessageArray;
    UIButton *editButton;
}
-(void)createUserMessage;
@property(nonatomic,strong)NSMutableArray *dataArray;

@property(nonatomic,strong)NSArray *USEDataArray;

@property(nonatomic,strong)NSDictionary *dataDict;
@end
