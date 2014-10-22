//
//  RefreshCollectionView.m
//  hangcom-ui
//
//  Created by 无忧 on 14-5-6.
//  Copyright (c) 2014年 sam. All rights reserved.
//

#import "RefreshCollectionView.h"

@implementation RefreshCollectionView


@synthesize enableFooter;
@synthesize enableHeader;
@synthesize parent;

- (id)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout
{
    self = [super initWithFrame:frame collectionViewLayout:layout];
    if (self) {
        // Initialization code
        [self createUI];
    }
    return self;
}

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect
 {
 // Drawing code
 }
 */

- (void)createUI
{
    CGSize size = self.frame.size;
    
    _refreshHeaderView = [[EGORefreshTableHeaderView alloc] initWithFrame:CGRectMake(0, 0-60, size.width, 60)];
    _refreshHeaderView.delegate = self;
    //[self addSubview:_refreshHeaderView];
    [_refreshHeaderView refreshLastUpdatedDate];
    
    _refreshFooterView = [[EGORefreshTableFooterView alloc] initWithFrame:CGRectMake(0, 0-60, size.width, 60)];
    _refreshFooterView.delegate = self;
//    [self addSubview:_refreshFooterView];
    [_refreshFooterView refreshLastUpdatedDate];
//    [self addSubview:_refreshFooterView];
}

- (void)setEnableFooter:(BOOL)tf
{
    enableFooter = tf;
    if (tf == YES) {
        if ([self.subviews containsObject:_refreshFooterView] == NO) {
            [self addSubview:_refreshFooterView];
        }
    } else {
        if ([self.subviews containsObject:_refreshFooterView] == YES) {
            [_refreshFooterView removeFromSuperview];
        }
    }
}

- (void)setEnableHeader:(BOOL)tf
{
    enableHeader = tf;
    if (tf == YES) {
        if ([self.subviews containsObject:_refreshHeaderView] == NO) {
            [self addSubview:_refreshHeaderView];
        }
    } else {
        if ([self.subviews containsObject:_refreshHeaderView] == YES) {
            [_refreshHeaderView removeFromSuperview];
        }
    }
}

- (void)updateFooter
{
    CGSize size = self.contentSize;
    CGSize size2 = self.frame.size;
    if (size.height < size2.height) {
        size.height = size2.height;
    }
    _refreshFooterView.frame = CGRectMake(0, size.height, size.width, 60);
}

- (void)dealloc
{
#if ! __has_feature(objc_arc)
    [_refreshHeaderView release];
    [_refreshFooterView release];
    [super dealloc];
#endif
}

#pragma mark UIScrollViewDelegate Methods

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    //NSLog(@"scrollViewDidScroll %f",scrollView.contentOffset.y);
    if (scrollView.contentOffset.y < 0) {
        [_refreshHeaderView egoRefreshScrollViewDidScroll:scrollView];
    } else if (scrollView.contentOffset.y > 44) {
        [_refreshFooterView egoRefreshScrollViewDidScroll:scrollView];
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    CGSize size = scrollView.frame.size;
    CGFloat offsety = scrollView.contentOffset.y;
    //NSLog(@"scrollViewDidEndDragging %f %f",scrollView.contentSize.height, offsety);
    
    CGFloat offset = scrollView.contentSize.height - size.height;
    if (offset < 0) {
        offset = 0;
    }
    if (enableHeader == YES && offsety < -44) {
        [_refreshHeaderView egoRefreshScrollViewDidEndDragging:scrollView];
    } else if (enableFooter == YES && offsety > offset+44) {
        [_refreshFooterView egoRefreshScrollViewDidEndDragging:scrollView];
    }
}

#pragma mark -

#pragma mark EGORefreshTableHeaderDelegate Methods

- (void)egoRefreshTableHeaderDidTriggerRefresh:(EGORefreshTableHeaderView*)view
{
    [self reloadHeaderTableViewDataSource];
}

- (BOOL)egoRefreshTableHeaderDataSourceIsLoading:(EGORefreshTableHeaderView*)view
{
	return _headerLoading;
}

- (NSDate*)egoRefreshTableHeaderDataSourceLastUpdated:(EGORefreshTableHeaderView*)view
{
	return [NSDate date];
}

- (void)egoRefreshTableFooterDidTriggerRefresh:(EGORefreshTableFooterView*)view
{
    [self reloadFooterTableViewDataSource];
}

- (BOOL)egoRefreshTableFooterDataSourceIsLoading:(EGORefreshTableFooterView*)view
{
    return _footerLoading;
}

- (NSDate*)egoRefreshTableFooterDataSourceLastUpdated:(EGORefreshTableFooterView*)view
{
    return [NSDate date];
}

- (void)reloadData
{
    [super reloadData];
    [self updateFooter];
}

- (void)reloadHeaderTableViewDataSource
{
    _headerLoading = YES;
    if (parent != nil && [parent respondsToSelector:@selector(loadHeader)] == YES) {
        [parent performSelector:@selector(loadHeader)];
    }
    [self performSelector:@selector(checkTimeout:) withObject:_refreshHeaderView afterDelay:2];
}

- (void)reloadFooterTableViewDataSource
{
	_footerLoading = YES;
    if (parent != nil && [parent respondsToSelector:@selector(loadFooter)] == YES) {
        [parent performSelector:@selector(loadFooter)];
    }
    [self performSelector:@selector(checkTimeout:) withObject:_refreshFooterView afterDelay:2];
}

- (void)finishLoadHeaderTableViewDataSource
{
    [self checkTimeout:_refreshHeaderView];
}

- (void)finishLoadFooterTableViewDataSource
{
    [self checkTimeout:_refreshFooterView];
}

- (void)checkTimeout:(id)view
{
    if ([view isKindOfClass:[EGORefreshTableHeaderView class]] == YES) {
        _headerLoading = NO;
        EGORefreshTableHeaderView *header = (EGORefreshTableHeaderView *)view;
        if ([header getState] != EGOOPullRefreshNormal) {
            [header egoRefreshScrollViewDataSourceDidFinishedLoading:self];
        }
    } else if ([view isKindOfClass:[EGORefreshTableFooterView class]] == YES) {
        _footerLoading = NO;
        EGORefreshTableFooterView *footer = (EGORefreshTableFooterView *)view;
        if ([footer getState] != EGOOPullRefreshNormal) {
            [footer egoRefreshScrollViewDataSourceDidFinishedLoading:self];
        }
    }
}

@end
