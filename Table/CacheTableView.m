//
//  CacheTableView.m
//  mcare-ui
//
//  Created by sam on 12-9-24.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "CacheTableView.h"
#import "TableViewCellDelegate.h"

@implementation CacheTableView

@synthesize cacheDelegte;

- (void)dealloc
{
    [self clearCacheData:self];
#if ! __has_feature(objc_arc)
    [cellList release];
    [super dealloc];
#endif
}

- (void)createUI
{
    cellList = [[NSMutableArray alloc] init];
    self.cacheDelegte = self;
    [super createUI];
}

- (void)clearCacheData:(UITableView *)tableView
{
    for (int i=0; i<cellList.count; i++) {
        //UITableViewCell *cell = [cellList objectAtIndex:i];
        //NSLog(@"dealloc %d %@ %d", i, cell, cell.retainCount);
    }
    [cellList removeAllObjects];
}

- (BOOL)isPreLoadCell:(UITableView *)tableView
{
    return YES;
}

- (UITableViewCell *)getTableViewCell:(NSIndexPath *)indexPath
{
    return nil;
}

- (void)insertTableCells:(NSArray *)array
{
    for (int i=0; i<array.count; i++) {
        [cellList insertObject:[NSNull null] atIndex:i];
    }
    for (int i=0; i<array.count; i++) {
        [self getTableViewCell:[NSIndexPath indexPathForRow:i inSection:0]];
    }
}

- (void)appendTableCells:(NSArray *)array
{
    NSInteger oldCount = cellList.count;
    
    for (int i=0; i<array.count; i++) {
        [cellList addObject:[NSNull null]];
    }
    for (int i=oldCount; i<array.count+oldCount; i++) {
        [self getTableViewCell:[NSIndexPath indexPathForRow:i inSection:0]];
    }
}

- (void)clearCacheInfo:(BOOL)isAll
{
    if (isAll == YES) {
        for (int i=0; i<cellList.count; i++) {
            id <TableViewCellDelegate> cell = [cellList objectAtIndex:i];
            [cell clearCacheInfo:nil];
        }
    } else {
        NSArray *array = [self indexPathsForVisibleRows];
        if (array.count > 0) {
            NSInteger min = [[array objectAtIndex:0] row];
            NSInteger max = [[array objectAtIndex:array.count-1] row];
            for (int i=0; i<cellList.count; i++) {
                if (i<min || i>max) {
                    id <TableViewCellDelegate> cell = [cellList objectAtIndex:i];
                    [cell clearCacheInfo:nil];
                }
            }
        } else {
            for (int i=0; i<cellList.count; i++) {
                id <TableViewCellDelegate> cell = [cellList objectAtIndex:i];
                [cell clearCacheInfo:nil];
            }
        }
    }
}
@end
