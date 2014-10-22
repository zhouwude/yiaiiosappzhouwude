//
//  ItemView.m
//  WXMovie
//
//  Created by 石显军 on 14-2-20.
//  Copyright (c) 2014年 无线互联3g学院. All rights reserved.
//

#import "ItemView.h"

@implementation ItemView

#pragma mark - 生命方法
- (id)initWithNamed:(NSString *)imageNamed
              title:(NSString *)title
{
    self = [super init];
    if (self) {
        _itemView = [[UIImageView alloc] init];
        _itemView.backgroundColor = [UIColor clearColor];
        _itemView.image = [UIImage imageNamed:imageNamed];
        _itemView.contentMode = UIViewContentModeCenter;
        [self addSubview:_itemView];
        
        //添加标题
        _itemTitle = [[UILabel alloc] init];
        _itemTitle.font = [UIFont boldSystemFontOfSize:9];
        _itemTitle.textAlignment = NSTextAlignmentCenter;
        _itemTitle.textColor = [UIColor grayColor];
        _itemTitle.text = title;
        _itemTitle.backgroundColor = [UIColor clearColor];
        [self addSubview:_itemTitle];
    }
    return self;
}


#pragma mark - 设置子视图farme
- (void)setItemTitleFrame:(CGRect)itemTitleFrame
{
    _itemTitle.frame = itemTitleFrame;
}
- (void)setItemViewFrame:(CGRect)itemViewFrame
{
    _itemView.frame = itemViewFrame;
}


@end
