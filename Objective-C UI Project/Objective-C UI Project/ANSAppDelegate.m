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

static const NSUInteger kANSObjectCount   = 100;

@interface ANSAppDelegate ()
@property (nonatomic, retain) ANSUsersModel *collection;

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
    
    ANSPerformInAsyncQueue(ANSPriorityDefault, ^{
        sleep(5);
         NSArray *objects = [NSArray objectsWithCount:kANSObjectCount block:^id{
            return [[ANSUser alloc] init];
        }];
        
        ANSUsersModel *collection = [ANSUsersModel new];
        [collection addObjects:objects];
        // [ANSObjectCollection loadState] ? :
        ANSPerformInMainQueue(dispatch_async, ^{
            controller.collection = collection;
        });
    });

    controller.collection = [ANSUsersModel modelWithCount:kANSObjectCount block:^id{
        return [ANSUser new];
    }];
    
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
