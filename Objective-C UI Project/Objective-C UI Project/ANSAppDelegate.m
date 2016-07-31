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

static NSString * const kANSArchive     = @"kANSArchive";
static const NSUInteger kANSDataCount   = 3;

@interface ANSAppDelegate ()
@property (nonatomic, retain) ANSDataCollection *collection;

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
    
    NSArray *objects = [NSArray objectsWithCount:kANSDataCount block:^id{
        return [[ANSData alloc] init];
    }];
    
    ANSDataCollection *collection = [ANSDataCollection new];
    self.collection = collection;
    
    controller.collection = collection;
    [collection addDataObjects:objects];
    
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    NSLog(@"applicationWillResignActive");
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    NSLog(@"applicationDidEnterBackground");
    [self saveCollection];
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    NSLog(@"applicationDidEnterBackground");
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    NSLog(@"applicationDidBecomeActive");
}

- (void)applicationWillTerminate:(UIApplication *)application {
    NSLog(@"applicationWillTerminate");
    [self saveCollection];
}

#pragma mark -
#pragma mark Save and loading

- (void)saveCollection {
    NSData *archive = [NSKeyedArchiver archivedDataWithRootObject:self.collection];
    [[NSUserDefaults standardUserDefaults] setObject:archive forKey:kANSArchive];
}

- (void)loadCollection {
    NSData *archive = [[NSUserDefaults standardUserDefaults] objectForKey:kANSArchive];
    if (archive) {
        [NSKeyedUnarchiver unarchiveObjectWithData:archive];
    }
}

@end
