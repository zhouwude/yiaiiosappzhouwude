//
//  LiebTableViewCell.m
//  北大爱思唯尔
//
//  Created by 倒霉熊丶 on 14-8-5.
//  Copyright (c) 2014年 www.healthedu.cn 北大爱思唯尔教育. All rights reserved.
//

#import "LiebTableViewCell.h"
#import "personalCenterModel.h"
@implementation LiebTableViewCell

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)configUI:(personalCenterModel *)model number:(NSInteger)tag{
    switch (tag) {
        case 1:
            self.subjectName.text = model.fullname;
            //self.timeLabel.text = model.category;
            //NSLog(@"%@",model.personalCenterModelID);
            
            break;
        case 2:
            self.subjectName.text = model.model.fullname;
            //self.timeLabel.text = model.model.category;
            
            
            break;
            
        default:
            break;
    }
    
    
    
    
    
}
@end
