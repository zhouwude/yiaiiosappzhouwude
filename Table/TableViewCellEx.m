//
//  TableViewCellEx.m
//  hangcom-ui
//
//  Created by lyuan on 14-3-1.
//  Copyright (c) 2014年 sam. All rights reserved.
//

#import "TableViewCellEx.h"

@implementation TableViewCellEx

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
