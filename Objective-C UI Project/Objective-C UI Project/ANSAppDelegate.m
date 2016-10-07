//
//  ANSAppDelegate.m
//  Objective-C UI Project
//
//  Created by Nikola Andriiev on 19.07.16.
//  Copyright © 2016 Andriiev.Mykola. All rights reserved.
//

#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <CoreData/CoreData.h>

#import "ANSAppDelegate.h"

#import "ANSLoginViewController.h"

#import "ANSFriendListViewController.h"
#import "ANSFBUser.h"
#import "ANSChangeModel.h"

#import "NSArray+ANSExtension.h"
#import "ANSGCD.h"
#import "ANSCoreDataManager.h"

@interface ANSAppDelegate ()
@property (nonatomic, strong) ANSCoreDataManager *dataManager;

@end

@implementation ANSAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [[FBSDKApplicationDelegate sharedInstance] application:application
                             didFinishLaunchingWithOptions:launchOptions];
    
    UIWindow *window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.window = window;
    

    ANSLoginViewController *controller  = [ANSLoginViewController new];
    UINavigationController *navigationController;
    navigationController = [[UINavigationController alloc] initWithRootViewController:controller];
    window.rootViewController = navigationController;
    self.dataManager = [ANSCoreDataManager sharedManagerWithMomName:@"ANSUsersMom"];
    
    [window makeKeyAndVisible];
    
#pragma mark -
#pragma mark Extra third task
    
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
