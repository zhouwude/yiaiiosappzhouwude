//
//  LiebTableViewCell.h
//  北大爱思唯尔
//
//  Created by 倒霉熊丶 on 14-8-5.
//  Copyright (c) 2014年 www.healthedu.cn 北大爱思唯尔教育. All rights reserved.
//

#import <UIKit/UIKit.h>
@class personalCenterModel;
@interface LiebTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *subjectImage;

@property (weak, nonatomic) IBOutlet UILabel *subjectName;




-(void)configUI:(personalCenterModel *)model number:(NSInteger)tag;
@end
