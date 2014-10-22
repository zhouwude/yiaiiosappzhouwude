//
//  CollectViewController.h
//  北大爱思唯尔
//
//  Created by 周武德 on 14-9-20.
//  Copyright (c) 2014年 www.healthedu.cn 北大爱思唯尔教育. All rights reserved.
//

#import "ZCFBaseViewController.h"

@interface CollectViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UIAlertViewDelegate>{
    UIView *view;
   
}

@property(nonatomic,strong)UITableView *tableView;
@end
