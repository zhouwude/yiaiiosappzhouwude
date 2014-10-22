//
//  DetailModel.h
//  北大爱思唯尔
//
//  Created by me2 on 14-9-1.
//  Copyright (c) 2014年 www.healthedu.cn 北大爱思唯尔教育. All rights reserved.
//

#import "BaseModel.h"

@interface DetailModel : BaseModel
@property(nonatomic,strong)NSDictionary *CourseExpRel;
@property(nonatomic,strong)NSDictionary *dataZh;
@property(nonatomic,strong)NSString *iphone_url;
@property(nonatomic,strong)NSString*summary;
@property(nonatomic,strong)NSString*fullname;
@property(nonatomic,strong)DetailModel *model;
@property(nonatomic,strong)DetailModel *dataModel;
@property(nonatomic,strong)NSString *price;
@property(nonatomic,strong)NSString *authordescription;
@property(nonatomic,strong)NSString *speaker;
@property(nonatomic,strong)NSString *speakerorg;
@property(nonatomic,strong)NSString *courseid;
@property(nonatomic,strong)NSString*uid;
@property(nonatomic,strong)NSString*STORAGE_PATH;


@end
