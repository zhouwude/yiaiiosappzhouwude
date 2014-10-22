//
//  CacheTableView.h
//  mcare-ui
//
//  Created by sam on 12-9-24.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "RefreshTableView.h"
#import "TableViewDelegate.h"

@interface CacheTableView : RefreshTableView <TableViewDelegate> {
    NSMutableArray *cellList;
    __unsafe_unretained id cacheDelegte;
}

- (void)insertTableCells:(NSArray *)array;
- (void)appendTableCells:(NSArray *)array;
- (void)clearCacheInfo:(BOOL)isAll;

@property (nonatomic, assign) id cacheDelegte;

@end