//
//  beginEditViewController.h
//  北大爱思唯尔
//
//  Created by 周武德 on 14-10-11.
//  Copyright (c) 2014年 www.healthedu.cn 北大爱思唯尔教育. All rights reserved.
//

#import "ZCFBaseViewController.h"

@interface beginEditViewController : ZCFBaseViewController<UITextFieldDelegate>
@property(nonatomic,assign)id parent;
@property(nonatomic,strong)NSString *message;
@property(nonatomic,assign)NSInteger rowNum;

@end
