//
//  ItemView.h
//  WXMovie
//
//  Created by 石显军 on 14-2-20.
//  Copyright (c) 2014年 无线互联3g学院. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ItemView : UIControl
{
@private
    UIImageView *_itemView;              //子视图 UIImageView
    UILabel     *_itemTitle;             //子视图 UILable
    CGRect       _itemViewFrame;         //子视图 _itemView 的frame
    CGRect       _itemTitleFrame;        //子视图 _itemTitle的frame   
}
@property (nonatomic, readonly) UILabel *itemTitle;
@property (nonatomic, readonly) UIImageView *itemView;
#pragma mark - 设置子视图的Frame

@property (nonatomic, assign)CGRect itemViewFrame;
@property (nonatomic, assign)CGRect itemTitleFrame;

- (void)setItemTitleFrame:(CGRect)itemTitleFrame;
- (void)setItemViewFrame:(CGRect)itemViewFrame;

#pragma mark - 自定义初始化方法
/**
 * @方法 initWithNamed:imageNamed:
 * @概述 初始化此视图 视图由两个子视图组成 UIImageView和UILabel
 * @参数 
 *       @imageNamed,属性_itemView图片的名称
 *       @title     ,属性_itemTitle的text属性
 * @返回 ItemView实例
 * @讨论 
 **/
- (id)initWithNamed:(NSString *)imageNamed title:(NSString *)title;
@end
