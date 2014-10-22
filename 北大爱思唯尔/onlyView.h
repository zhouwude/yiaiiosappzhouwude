//
//  onlyView.h
//  北大爱思唯尔
//
//  Created by 周武德 on 14-10-13.
//  Copyright (c) 2014年 www.healthedu.cn 北大爱思唯尔教育. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TapImageView.h"
@interface onlyView : UIView<IamgeDelegate>{
    TapImageView *imageView;
    UILabel *label;
}
-(void)loadData:(NSString *)str;
@property(nonatomic,assign)id pratent;
@end
