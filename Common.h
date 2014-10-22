//
//  Common.h
//  WXWeibo
//
//  Created by 喵~ on 14-3-31.
//  Copyright (c) 2014年 无线互联3g学院. All rights reserved.
//

#ifndef WXWeibo_Common_h
#define WXWeibo_Common_h

/**
 * ------------- Frame设置  --------------
 */
#define kMainHeight 180

typedef enum {
    Implantology,
    Nurse,
    Manage,
    Cmecourse,
    Enterprise,
    Online
}NewUrl_Every;
#define kScreenHeight [UIScreen mainScreen].bounds.size.height
#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define kTabBarHeight 49
#define kStatusHeight 20
#define kNavgationHeight 44
#define kControllHeight 41
#define REmotePartUrl @"?r=cme2014/api/Getcourselist&p_id=%@"

/**
 * -------------- 系统版本  --------------
 */

#define UIColorFromRGB(rgbValue) [UIColor \colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
#define UIColorFromRGB2(r, g, b) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1.0]


#define kSysVersion [[UIDevice currentDevice].systemVersion floatValue]
/**
 * -------------- 访问地址  --------------
 */
#define homeURL [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES) firstObject]
#define kBaseURL @"http://kouqiang.yiaiwang.com.cn/index.php"
#define kRemoteURL @"?r=cme2014/api"  // 远程菜单参数
#define kCountryURL @"?r=cme2014/api/getclassroom&menu_str=country_course"
#define kCanURL @"?r=cme2014/api/getclassroom&menu_str=learn_course"
#define kOtherURL @"?r=cme2014/api/getclassroom&menu_str=other_course"
#define FACETOFACEURL @"http://kouqiang.yiaiwang.com.cn/index.php?r=cme2014/api/getclassroom&menu_str=%@"
#define FACETOFACEALLURL @"country_course"
#define LEARNPARME @"learn_course"
#define OTHERPARME @"other_course"
#define LOGIN @"alreadyLogin"
#define FIRST @"firstLogin"
#define NOTIFICATION @"notifiction"
#define CREATE_WEAK_SELF    __weak typeof(self) weakSelf = self
#define USERID @"userID"
#define REQUEST @"SXJDataService.h"
#define ACTION @"Action"
#define TOPViewCOntroller self.navigationController.topViewController==self

/**
 *  ------------- Debug模式 -------------
 */
//__VA_ARGS__:表示一个可变的参数宏，... 表示多个参数
#ifdef DEBUG
#define DLog(...) NSLog(__VA_ARGS__)
#else
#define DLog(...)
#endif

/**
 *  -------------  内存设置  -------------
 */
#define kSafeRelease(object) [object release], object = nil
#define IOSVerSion [[[UIDevice currentDevice] systemVersion] floatValue]>7.0
/**
 *  ------------- 定义通知 -------------
 */
#define kDidChangeThemeNotification @"DidChangeFoodClass"
#define kHodoGreen [UIColor colorWithRed:131/255.0 green:195/255.0 blue:66/255.0 alpha:1]
#define kHodoGray [UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1]
#define kHodoZhuCe [UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1]
#define kHodoBGColor [UIColor colorWithRed:239.0/255.0 green:239.0/255.0 blue:244.0/255.0 alpha:1.0];
#define FACETOFACEURL @"http://kouqiang.yiaiwang.com.cn/index.php?r=cme2014/api/getclassroom&menu_str=country_course"
#define kHodoxuanzhong [UIColor colorWithRed:218.0/255.0 green:218.0/255.0 blue:218.0/255.0 alpha:1.0];
/**
 *  -------------  其他设置  -------------
 */
// 列表视图 宽度
#define kListViewWidth 270
/// 用户滑动的宽度设置
#define kMoveWidth 100

// 猫的路径
#define kCatPath @"Skins/cat/"
#define Image(a) [UIImage imageNamed:a]
#define kThemeName @"themeName"
#define kClassData @"ClassificationData"
#define USERNAME @"usename"
#define BALANCE @"balance"
#define DEFAULT(a) [[NSUserDefaults standardUserDefaults] objectForKey:a]
#define SETDEFAULT(a,b) [[NSUserDefaults standardUserDefaults] setObject:a forKey:b]
#endif
