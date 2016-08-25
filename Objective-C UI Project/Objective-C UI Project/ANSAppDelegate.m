//
//  ANSAppDelegate.m
//  Objective-C UI Project
//
//  Created by Nikola Andriiev on 19.07.16.
//  Copyright © 2016 Andriiev.Mykola. All rights reserved.
//

#import "ANSAppDelegate.h"

#import "ANSViewControllerTables.h"
#import "ANSViewControllerFirstTask.h"
#import "ANSUser.h"
#import "ANSChangeModel.h"

#import "NSArray+ANSExtension.h"
#import "ANSGCD.h"

@interface ANSAppDelegate ()
@property (nonatomic, strong) ANSUsersModel *users;

@end

@implementation ANSAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    NSLog(@"didFinishLaunchingWithOptions");
    UIWindow *window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.window = window;
    
    ANSViewControllerTables *controller = [ANSViewControllerTables new];
    UINavigationController *navigationController;
    navigationController = [[UINavigationController alloc] initWithRootViewController:controller];
    window.rootViewController = navigationController;
    
    [window makeKeyAndVisible];
    
#pragma mark -
#pragma mark Extra

    self.users = [ANSUsersModel new];
    controller.users = self.users;
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    NSLog(@"applicationWillResignActive");
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    [self.users save];
    NSLog(@"applicationDidEnterBackground");
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    NSLog(@"applicationDidEnterBackground");
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    NSLog(@"applicationDidBecomeActive");
}

- (void)applicationWillTerminate:(UIApplication *)application {
    [self.users save];
    NSLog(@"applicationWillTerminate");
}

@end
