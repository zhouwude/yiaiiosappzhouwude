//
//  CustomCell.h
//  北大爱思唯尔
//
//  Created by me2 on 14-8-25.
//  Copyright (c) 2014年 www.healthedu.cn 北大爱思唯尔教育. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FacetofaceModel.h"
#import "RemoteModel.h"
@interface CustomCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *headerView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel2;


@property (weak, nonatomic) IBOutlet UIImageView *priceImageView;




@property (weak, nonatomic) IBOutlet UILabel *nameLabel3;




-(void)configUI:(FacetofaceModel *)model;

-(void)configRemote:(RemoteModel *)model;
@end
