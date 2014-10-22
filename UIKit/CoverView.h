//
//  CoverView.h
//  mcare-ui
//
//  Created by sam on 12-9-1.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CoverView : UIView {
    __unsafe_unretained id parent;
}

+ (UIImageView *)createImageView:(UIImage *)image frame:(CGRect)frame;

@property (nonatomic, assign) id parent;

@end
