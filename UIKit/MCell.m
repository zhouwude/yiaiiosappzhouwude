//
//  MCell.m
//  mcarepatient
//
//  Created by sam on 12-8-20.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "MCell.h"

@implementation MCell

@synthesize height;
@synthesize className;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        className = [reuseIdentifier copy];
        [self createUI];
    }
    return self;
}

- (void)createUI
{
    
}

+ (MCell *)getCellForType:(NSString *)type cells:(NSArray *)cells
{
    MCell *mcell = nil;
    for (int i=0; i<cells.count; i++) {
        NSObject *obj = [cells objectAtIndex:i];
        if ([obj isKindOfClass:[NSArray class]] == YES) {
            NSArray *array = (NSArray *)obj;
            for (int j=0; j<array.count; j++) {
                MCell *cell = [array objectAtIndex:j];
                if ([cell.className isEqualToString:type] == YES) {
                    mcell = cell;
                    break;
                }
            }
            if (mcell == nil) {
                continue;
            }
        } else {
            MCell *cell = (MCell *)obj;
            if ([cell.className isEqualToString:type] == YES) {
                mcell = cell;
                break;
            }
        }
    }
    return mcell;
}

@end
