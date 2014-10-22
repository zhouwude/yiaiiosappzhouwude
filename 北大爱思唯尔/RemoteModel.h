//
//  RemoteModel.h
//  北大爱思唯尔
//
//  Created by 倒霉熊丶 on 14-7-14.
//  Copyright (c) 2014年 www.healthedu.cn 北大爱思唯尔教育. All rights reserved.
//

#import "BaseModel.h"

@interface RemoteModel : BaseModel

@property (nonatomic, strong)NSString       *title;
@property (nonatomic, strong)NSString       *url;
@property (nonatomic, strong)NSMutableArray *childs;
@property(nonatomic,strong)NSString       *date;
@property(nonatomic,strong)NSString       *create_time;
@property(nonatomic,strong)NSString       *dept_name;
@property(nonatomic,strong)NSString       *dept_post;
@property(nonatomic,strong)NSString       *effect;
@property(nonatomic,strong)NSString       *innovation;
@property(nonatomic,strong)NSString        *questiones;
@property(nonatomic,strong)NSString       *target;
@property(nonatomic,strong)NSString       *name;
@property(nonatomic,strong)NSString       *id;
@property(nonatomic,strong)NSString       *fullname;
@property(nonatomic,strong)NSString       *summary;
@property(nonatomic,strong)NSString       *coursecategoryid;
@property(nonatomic,strong)NSString       *RemoteModelID;
@property(nonatomic,strong)NSString       *authordescription;
@property(nonatomic,strong)NSString       *speaker;
@property(nonatomic,strong)NSString       *speakerorg;
@property(nonatomic,strong)NSString       *price;
@property(nonatomic,strong)NSString       *uid;
@property(nonatomic,strong)NSString       *cate_id;
@property(nonatomic,strong)NSString       *cate_name;
@end
