//
//  BadgeView.h
//  mcare-ui
//
//  Created by sam on 12-10-8.
//
//

#import <UIKit/UIKit.h>

@interface BadgeView : UIView {
    UIImageView *imageView;
    UILabel *label;
    
    CGFloat width;
    CGFloat height;
}

- (void)setBadge:(NSString *)badge;

@property (nonatomic, readonly) CGFloat width;
@property (nonatomic, readonly) CGFloat height;

@end
