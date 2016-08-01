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

static const NSUInteger kANSDataCount   = 0;

@interface ANSAppDelegate ()
@property (nonatomic, retain) ANSDataCollection *collection;

@end

@implementation ANSAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    NSLog(@"didFinishLaunchingWithOptions");
    UIWindow *window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.window = window;
    
  ANSViewControllerTables *controller = [ANSViewControllerTables new];
// ANSViewControllerFirstTask *controller1 = [ANSViewControllerFirstTask new];
    
    window.rootViewController = controller;
    
    [window makeKeyAndVisible];
    
#pragma mark -
#pragma mark Extra
    
    //test objects
   __unused NSArray *objects = [NSArray objectsWithCount:kANSDataCount block:^id{
        return [[ANSData alloc] init];
    }];
    
    ANSDataCollection *collection = [ANSDataCollection loadState] ? : [ANSDataCollection new];
    self.collection = collection;
    controller.collection = collection;

    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    NSLog(@"applicationWillResignActive");
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    [ANSDataCollection saveState];
    NSLog(@"applicationDidEnterBackground");
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    NSLog(@"applicationDidEnterBackground");
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    NSLog(@"applicationDidBecomeActive");
}

- (void)applicationWillTerminate:(UIApplication *)application {
    [ANSDataCollection saveState];
    NSLog(@"applicationWillTerminate");
}

#pragma mark -
#pragma mark Private methods

@end
