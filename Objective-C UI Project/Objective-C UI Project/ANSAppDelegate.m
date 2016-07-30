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
#import "ANSData.h"

#import "NSArray+ANSExtension.h"

@interface ANSAppDelegate ()

@end

@implementation ANSAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    UIWindow *window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.window = window;
    
  ANSViewControllerTables *controller = [ANSViewControllerTables new];
// ANSViewControllerFirstTask *controller1 = [ANSViewControllerFirstTask new];
    
    window.rootViewController = controller;
    
    [window makeKeyAndVisible];
    
#pragma mark -
#pragma mark Extra
    
    NSArray *objects = [NSArray objectsWithCount:100 block:^id{
        return [[ANSData alloc] init];
    }];
    
    ANSDataCollection *collection = [ANSDataCollection new];
    controller.collection = collection;
    
    [collection addDataObjects:objects];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {

}

- (void)applicationDidEnterBackground:(UIApplication *)application {

}

- (void)applicationWillEnterForeground:(UIApplication *)application {

}

- (void)applicationDidBecomeActive:(UIApplication *)application {

}

- (void)applicationWillTerminate:(UIApplication *)application {

}

@end
