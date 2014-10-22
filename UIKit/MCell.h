//
//  MCell.h
//  mcarepatient
//
//  Created by sam on 12-8-20.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MCell : UITableViewCell {
    CGFloat height;
    NSString *className;
}

- (void)createUI;
+ (MCell *)getCellForType:(NSString *)type cells:(NSArray *)cells;

@property (nonatomic, assign) CGFloat height;
@property (nonatomic, readonly) NSString *className;

@end
