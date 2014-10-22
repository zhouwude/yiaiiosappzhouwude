//
//  registerrViewController.h
//  北大爱思唯尔
//
//  Created by 周武德 on 14-9-28.
//  Copyright (c) 2014年 www.healthedu.cn 北大爱思唯尔教育. All rights reserved.
//

#import "ZCFBaseViewController.h"
#import "registerView.h"
@interface registerrViewController : ZCFBaseViewController<UITextFieldDelegate,UITextViewDelegate,UIScrollViewDelegate>{
    registerView *registerview;
    
   }
@property(nonatomic,assign)CGFloat heightCount;

@end
