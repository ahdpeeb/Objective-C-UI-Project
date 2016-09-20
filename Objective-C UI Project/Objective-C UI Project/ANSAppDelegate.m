//
//  ANSAppDelegate.m
//  Objective-C UI Project
//
//  Created by Nikola Andriiev on 19.07.16.
//  Copyright © 2016 Andriiev.Mykola. All rights reserved.
//

#import <FBSDKCoreKit/FBSDKCoreKit.h>

#import "ANSAppDelegate.h"

#import "ANSLoginViewController.h"

#import "ANSViewControllerTables.h"
#import "ANSUser.h"
#import "ANSChangeModel.h"

#import "NSArray+ANSExtension.h"
#import "ANSGCD.h"

@interface ANSAppDelegate ()
@property (nonatomic, strong) ANSUsersModel *users;

@end

@implementation ANSAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [[FBSDKApplicationDelegate sharedInstance] application:application
                             didFinishLaunchingWithOptions:launchOptions];
    
    UIWindow *window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.window = window;
    
    ANSViewControllerTables *controller = [ANSViewControllerTables new];
//    ANSLoginViewController *controller  = [ANSLoginViewController new];
    UINavigationController *navigationController;
    navigationController = [[UINavigationController alloc] initWithRootViewController:controller];
    window.rootViewController = navigationController;
    
    [window makeKeyAndVisible];
    
#pragma mark -
#pragma mark Extra third task

    self.users = [ANSUsersModel new];
    controller.users = self.users;
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    NSLog(@"applicationWillResignActive");
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    NSLog(@"applicationDidEnterBackground");
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    NSLog(@"applicationDidEnterBackground");
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
     [FBSDKAppEvents activateApp];
}

- (void)applicationWillTerminate:(UIApplication *)application {
    NSLog(@"applicationWillTerminate");
}

- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation {
    return [[FBSDKApplicationDelegate sharedInstance] application:application
                                                          openURL:url
                                                sourceApplication:sourceApplication
                                                       annotation:annotation];
}

@end
