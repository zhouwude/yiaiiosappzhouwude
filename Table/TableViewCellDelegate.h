//
//  TableViewCellDelegate.h
//  mcare-core
//
//  Created by sam on 12-8-6.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol TableViewCellDelegate

- (BOOL)isPreLoadPhoto:(UIImageView *)imageView;
+ (CGFloat)getCellHeight:(id)info width:(CGFloat)width;
- (void)loadCacheInfo:(id)info;
- (void)clearCacheInfo:(id)info;

@end
