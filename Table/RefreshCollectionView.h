//
//  RefreshCollectionView.h
//  hangcom-ui
//
//  Created by 无忧 on 14-5-6.
//  Copyright (c) 2014年 sam. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EGORefreshTableHeaderView.h"
#import "EGORefreshTableFooterView.h"

@interface RefreshCollectionView : UICollectionView<EGORefreshTableHeaderDelegate, EGORefreshTableFooterViewDelegate> {
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

@property (nonatomic, assign) BOOL enableHeader;
@property (nonatomic, assign) BOOL enableFooter;
@property (nonatomic, assign) id parent;

@end

@protocol RefreshCollectionDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView;
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate;

@optional

- (void)loadHeader;
- (void)loadFooter;

@end
