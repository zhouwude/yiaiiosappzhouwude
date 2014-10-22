//
//  personalCenterModel.h
//  北大爱思唯尔
//
//  Created by me2 on 14-8-27.
//  Copyright (c) 2014年 www.healthedu.cn 北大爱思唯尔教育. All rights reserved.
//

#import "BaseModel.h"

@interface personalCenterModel : BaseModel

@property(nonatomic,strong)NSString *address;
@property(nonatomic,strong)NSString *code;
@property(nonatomic,strong)NSString *create_date;
@property(nonatomic,strong)NSString *education;
@property(nonatomic,strong)NSString *folk;
@property(nonatomic,strong)NSString *grade;
@property(nonatomic,strong)NSString *id;
@property(nonatomic,strong)NSString *last_login_date;
@property(nonatomic,strong)NSString *last_login_ip;
@property(nonatomic,strong)NSString *position;
@property(nonatomic,strong)NSString *true_name;
@property(nonatomic,strong)NSString *user_name;
@property(nonatomic,strong)NSString *zipcode;
@property(nonatomic,strong)NSString *personalCenterModelID;
@property(nonatomic,strong)NSString *fullname;
@property(nonatomic,strong)NSString *category;
@property(nonatomic,strong)NSDictionary *Course;
@property(nonatomic,strong)personalCenterModel *model;
@property(nonatomic,strong)NSString *money;
@property(nonatomic,strong)NSString *credit1;
@property(nonatomic,strong)NSString *credit2;
@property(nonatomic,strong)NSString *credit3;
@property(nonatomic,strong)NSString *credit4;
@property(nonatomic,strong)NSString *fk_updateuser_id;
@property(nonatomic,strong)NSString *gender;
@property(nonatomic,strong)NSString *cardno;
@property(nonatomic,strong)NSString *update_time;

@end
