//
//  QuestionModel.h
//  北大爱思唯尔
//
//  Created by me2 on 14-9-11.
//  Copyright (c) 2014年 www.healthedu.cn 北大爱思唯尔教育. All rights reserved.
//

#import "BaseModel.h"

@interface QuestionModel : BaseModel

@property(nonatomic,strong)NSString *CONTENT;
@property(nonatomic,strong)NSString *CREATE_DATE;
@property(nonatomic,strong)NSString *ID;
@property(nonatomic,strong)NSString *QUESTION_LABEL_ID;
@property(nonatomic,strong)NSString *STATE;
@property(nonatomic,strong)NSString *QUESTION_ID;
@property(nonatomic,strong)NSString *SEQ;
@property(nonatomic,strong)NSArray *ans;
@property(nonatomic,strong)NSMutableArray *dataArray;


@end
