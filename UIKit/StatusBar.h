//
//  StatusBar.h
//  mcare-ui
//
//  Created by sam on 12-10-10.
//
//

#import <UIKit/UIKit.h>

#define BAR_WIDTH 320

@interface StatusBar : UIWindow {
    UIView *bgView;
    UIImageView *imageView;
    UILabel *label;
}

+ (void)showMessage:(NSString *)message duration:(CGFloat)duration;
+ (void)hideStatus;
+ (StatusBar *)shareInstance;

@end
