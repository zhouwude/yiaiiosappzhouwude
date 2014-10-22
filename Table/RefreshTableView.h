//
//  RefreshTableView.h
//  mcare-ui
//
//  Created by sam on 12-9-24.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "TableViewEx.h"
#import "EGORefreshTableHeaderView.h"
#import "EGORefreshTableFooterView.h"

@interface RefreshTableView : TableViewEx <EGORefreshTableHeaderDelegate, EGORefreshTableFooterViewDelegate> {
    EGORefreshTableHeaderView *_refreshHeaderView;
    EGORefreshTableFooterView *_refreshFooterView;
    
    BOOL _headerLoading;
    BOOL _footerLoading;
    
    BOOL enableHeader;
    BOOL enableFooter;
    
    __unsafe_unretained id parent;
}

- (void)createUI;
- (void)updateFooter;

- (void)reloadHeaderTableViewDataSource;
- (void)reloadFooterTableViewDataSource;
- (void)finishLoadHeaderTableViewDataSource;
- (void)finishLoadFooterTableViewDataSource;
- (void)reloadViewSize;

@property (nonatomic, assign) BOOL enableHeader;
@property (nonatomic, assign) BOOL enableFooter;
@property (nonatomic, assign) id parent;

@end

@protocol RefreshTableViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView;
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate;

@optional

- (void)loadHeader;
- (void)loadFooter;

@end