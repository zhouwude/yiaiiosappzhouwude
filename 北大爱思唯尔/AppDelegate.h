//
//  AppDelegate.h
//  北大爱思唯尔
//
//  Created by 倒霉熊丶 on 14-6-13.
//  Copyright (c) 2014年 www.healthedu.cn 北大爱思唯尔教育. All rights reserved.
//

#import <UIKit/UIKit.h>


@class LandedViewController;
@interface AppDelegate : UIResponder <UIApplicationDelegate>
{

Reachability  *hostReach;



}


//@property (nonatomic, strong) UINavigationController *navController;


@property (strong, nonatomic) UIWindow *window;
@property(nonatomic,strong) NSString *shareID;
@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;
+ (void) showStatusWithText:(NSString *) string duration:(NSTimeInterval) duration;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;

@end
