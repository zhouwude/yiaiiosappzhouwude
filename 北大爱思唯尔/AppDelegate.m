//
//  AppDelegate.m
//  北大爱思唯尔
//
//  Created by 倒霉熊丶 on 14-6-13.
//  Copyright (c) 2014年 www.healthedu.cn 北大爱思唯尔教育. All rights reserved.
//

#import "AppDelegate.h"
#import "MainViewController.h"
#import "LandedViewController.h"
#import "CfScrollView.h"
#import "Animation.h"
#import "UMSocial.h"
#import "landNaiViewController.h"
@interface AppDelegate ()
@property (nonatomic, strong) UIWindow * statusWindow;
@property (nonatomic, strong) UILabel * statusLabel;
- (void) dismissStatus;
@end

@implementation AppDelegate


@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;
- (void)reachabilityChanged:(NSNotification *)note {
    Reachability* curReach = [note object];
    NSParameterAssert([curReach isKindOfClass: [Reachability class]]);
    NetworkStatus status = [curReach currentReachabilityStatus];
    
    if (status == NotReachable) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"AppName"
                                                        message:@"失去网络，请检查网络"
                                                       delegate:nil
                                              cancelButtonTitle:@"YES" otherButtonTitles:nil];
        [alert show];
        
    }
}


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(reachabilityChanged:)
                                                 name: kReachabilityChangedNotification
                                               object: nil];
    hostReach = [Reachability reachabilityWithHostname:@"www.apple.com"];
    [hostReach startNotifier];
    self.statusWindow = [[UIWindow alloc] initWithFrame:CGRectZero];
    self.statusWindow.backgroundColor = [UIColor clearColor];
    
    self.statusWindow.windowLevel = UIWindowLevelStatusBar + 1;
    self.statusLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    self.statusLabel.backgroundColor = [UIColor blackColor];
    self.statusLabel.textColor = [UIColor whiteColor];
    self.statusLabel.font = [UIFont systemFontOfSize:12.0f];
    [self.statusWindow addSubview:self.statusLabel];
    [self.statusWindow makeKeyAndVisible];
    //[self.window setRootViewController:nil];
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    [UMSocialData setAppKey:@"538597e956240bdc070fb81a"];
    NSArray *path=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
    path = [path objectAtIndex:0];
    NSLog(@"~~~~%@",path);
    
    if ([[NSUserDefaults standardUserDefaults] objectForKey:FIRST]&&[[NSUserDefaults standardUserDefaults] objectForKey:LOGIN]){
        if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone){
        
        MainViewController *mainVC = [[MainViewController alloc] init];
        NSArray *path=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
        path = [path objectAtIndex:0];
        NSLog(@"~~~~%@",path);
        
        self.window.rootViewController = mainVC;
        }
        
    }else{
        if (![[NSUserDefaults standardUserDefaults] objectForKey:FIRST]){
            if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone){
            NSArray *array = [[NSArray alloc ] initWithObjects:@"Default@2x",@"Default@2x",@"Default@2x",@"Default@2x" ,nil];
            //NSLog(@"%@",array);
            CfScrollView *Sc = [[CfScrollView alloc] init];
            Sc.tag = 100;
            __block typeof (self)_weakSelf = self;
            Sc.backBlock = ^(){
                
                [[NSUserDefaults standardUserDefaults] setObject:FIRST forKey:FIRST];

                [[NSUserDefaults standardUserDefaults] synchronize];
                [self.window.layer addAnimation:[Animation Amimayion:kCATransitionFromRight] forKey:nil];
                LandedViewController *vc = [[LandedViewController alloc] init];
                landNaiViewController *nc = [[landNaiViewController alloc] initWithRootViewController:vc];
                vc.navigationController.navigationBar.hidden = YES;
                self.window.rootViewController = nc;
                [_weakSelf removeObject];
                
            };
            Sc.frame = [UIScreen mainScreen].bounds;
            [Sc configImage:array];
           
            [self.window addSubview:Sc];
            }
            
            
        }else{
        
        
            if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone){
        
        LandedViewController *vc = [[LandedViewController alloc] init];
           landNaiViewController *nc = [[landNaiViewController alloc] initWithRootViewController:vc];
            vc.navigationController.navigationBar.hidden = YES;
        self.window.rootViewController = nc;
            }
        }
        
    }
    
    
   
    [self.window makeKeyAndVisible];

    return YES;
}
+ (void) showStatusWithText:(NSString *) string duration:(NSTimeInterval) duration {
    
    AppDelegate * delegate = (AppDelegate *) [UIApplication sharedApplication].delegate;
    
    delegate.statusLabel.text = string;
    //sizeToFit的作用是根据string的字体和自适应大小。
    [delegate.statusLabel sizeToFit];
    CGRect rect = [UIApplication sharedApplication].statusBarFrame;
    NSLog(@"~~~%@",NSStringFromCGRect(rect));
    CGFloat width = delegate.statusLabel.frame.size.width;
    NSLog(@"%f",width);
    CGFloat height = rect.size.height;
    rect.origin.x = rect.size.width - width - 5;
    rect.size.width = width;
    delegate.statusWindow.frame = rect;
    delegate.statusLabel.frame = CGRectMake(0, 0, width, height);
    
    if (duration < 1.0) {
        duration = 1.0;
    }
    if (duration > 4.0) {
        duration = 4.0;
    }
    [delegate performSelector:@selector(dismissStatus) withObject:nil afterDelay:duration];
}

/**
 * @brief 干掉状态栏文字
 */
- (void) dismissStatus {
    CGRect rect = self.statusWindow.frame;
    rect.origin.y -= rect.size.height;//x=0-20;跑到屏幕可见区域之外了。。。。。
    [UIView animateWithDuration:0.5 animations:^{
        self.statusWindow.frame = rect;
        NSLog(@"~~~%@",NSStringFromCGRect(rect));
        
    }];
}


-(void)removeObject{
    CfScrollView *view = (CfScrollView *)[self.window viewWithTag:100];
    [view removeFromSuperview];
    
    
    
}


- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}
- (NSUInteger)application:(UIApplication *)application supportedInterfaceOrientationsForWindow:(UIWindow *)window
{
    return UIInterfaceOrientationMaskAllButUpsideDown;
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Saves changes in the application's managed object context before the application terminates.
    NSString *path = homeURL;
    NSFileManager *manager = [NSFileManager defaultManager];
    [manager removeItemAtPath:[path stringByAppendingString:@"/course.plist"] error:nil];
    
    [self saveContext];
}

- (void)saveContext
{
    NSError *error = nil;
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil) {
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
             // Replace this implementation with code to handle the error appropriately.
             // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. 
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        } 
    }
}

#pragma mark - Core Data stack

// Returns the managed object context for the application.
// If the context doesn't already exist, it is created and bound to the persistent store coordinator for the application.
- (NSManagedObjectContext *)managedObjectContext
{
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (coordinator != nil) {
        _managedObjectContext = [[NSManagedObjectContext alloc] init];
        [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    }
    return _managedObjectContext;
}

// Returns the managed object model for the application.
// If the model doesn't already exist, it is created from the application's model.
- (NSManagedObjectModel *)managedObjectModel
{
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"______" withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}

// Returns the persistent store coordinator for the application.
// If the coordinator doesn't already exist, it is created and the application's store added to it.
- (NSPersistentStoreCoordinator *)persistentStoreCoordinator
{
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"______.sqlite"];
    
    NSError *error = nil;
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
        /*
         Replace this implementation with code to handle the error appropriately.
         
         abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. 
         
         Typical reasons for an error here include:
         * The persistent store is not accessible;
         * The schema for the persistent store is incompatible with current managed object model.
         Check the error message to determine what the actual problem was.
         
         
         If the persistent store is not accessible, there is typically something wrong with the file path. Often, a file URL is pointing into the application's resources directory instead of a writeable directory.
         
         If you encounter schema incompatibility errors during development, you can reduce their frequency by:
         * Simply deleting the existing store:
         [[NSFileManager defaultManager] removeItemAtURL:storeURL error:nil]
         
         * Performing automatic lightweight migration by passing the following dictionary as the options parameter:
         @{NSMigratePersistentStoresAutomaticallyOption:@YES, NSInferMappingModelAutomaticallyOption:@YES}
         
         Lightweight migration will only work for a limited set of schema changes; consult "Core Data Model Versioning and Data Migration Programming Guide" for details.
         
         */
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }    
    
    return _persistentStoreCoordinator;
}

#pragma mark - Application's Documents directory

// Returns the URL to the application's Documents directory.
- (NSURL *)applicationDocumentsDirectory
{
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

@end
