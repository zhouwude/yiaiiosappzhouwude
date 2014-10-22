//
//  GradeHelper.h
//  hangcom-core
//
//  Created by 无忧 on 13-12-17.
//  Copyright (c) 2013年 sam. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^GradeHelperBlock)(BOOL sender);

@interface GradeHelper : NSObject

+ (void)inspectCondition;
+ (BOOL)getIsShowGrade;
+ (void)goToGrade;
+ (void)setGradeEvent:(NSString *)gradeEvent MyappID:(NSString *)MyappID;

@end
