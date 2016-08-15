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

static const NSUInteger kANSDataCount   = 0;

@interface ANSAppDelegate ()
@property (nonatomic, retain) ANSUsersCollection *collection;

@end

@implementation ANSAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    NSLog(@"didFinishLaunchingWithOptions");
    UIWindow *window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.window = window;
    
//    ANSViewControllerTables *controller = [ANSViewControllerTables new];
    ANSViewControllerFirstTask *controller1 = [ANSViewControllerFirstTask new];
    UINavigationController *nv = [[UINavigationController alloc] initWithRootViewController:controller1];
    window.rootViewController = nv;
    
    [window makeKeyAndVisible];
    
#pragma mark -
#pragma mark Extra
    
    //test objects
   __unused NSArray *objects = [NSArray objectsWithCount:kANSDataCount block:^id{
        return [[ANSUser alloc] init];
    }];
   
    ANSUsersCollection *collection = [ANSUsersCollection new];
    // [ANSDataCollection loadState] ? :
    self.collection = collection;
 //   controller.collection = collection;

    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    NSLog(@"applicationWillResignActive");
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    [self.collection saveState];
    NSLog(@"applicationDidEnterBackground");
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    NSLog(@"applicationDidEnterBackground");
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    NSLog(@"applicationDidBecomeActive");
}

- (void)applicationWillTerminate:(UIApplication *)application {
    [self.collection saveState];
    NSLog(@"applicationWillTerminate");
}

@end
