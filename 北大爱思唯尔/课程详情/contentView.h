//
//  contentView.h
//  北大爱思唯尔
//
//  Created by me2 on 14-9-10.
//  Copyright (c) 2014年 www.healthedu.cn 北大爱思唯尔教育. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DetailModel.h"
@interface contentView : UIView<UIScrollViewDelegate,UITableViewDataSource,UITableViewDelegate>{
    UIScrollView *sc;
    NSInteger selected;
    UILabel *introduceLabel;
    UITableView *_tabelView;
    UIScrollView *secendSC;
    UIScrollView *threeSc;
    NSMutableAttributedString *AAstring;
    UILabel *label1;
    UILabel *label2;
    UILabel *label3;
    UILabel *label4;
}
@property(nonatomic,strong)id parent;
@property(nonatomic,strong)NSArray *dataArray;
-(void)configUI:(DetailModel *)model array:(NSArray *)array contactData:(NSString *)courseData;

@end
