//
//  RemoteViewController.h
//  北大爱思唯尔
//
//  Created by 倒霉熊丶 on 14-7-14.
//  Copyright (c) 2014年 www.healthedu.cn 北大爱思唯尔教育. All rights reserved.
//

#import "ZCFBaseViewController.h"

@interface RemoteViewController : ZCFBaseViewController{
    NSString *strUrl ;
}
@property(nonatomic,strong)NSMutableArray *dataArray;
@property(nonatomic,strong)NSMutableArray *dataCell;
@property(nonatomic,strong)NSString *pID;


@end
