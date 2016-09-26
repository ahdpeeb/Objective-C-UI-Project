//
//  ANSFBFriends.m
//  Objective-C UI Project
//
//  Created by Nikola Andriiev on 22.09.16.
//  Copyright © 2016 Andriiev.Mykola. All rights reserved.
//
#import <UIKit/UIKit.h>

#import "ANSFBFriends.h"

#import "ANSNameFilterModel.h"
#import "ANSFBUser.h"

#import "NSArray+ANSExtension.h"
#import "NSFileManager+ANSExtension.h"
#import "ANSGCD.h"

#import "ANSMacros.h"

static NSString * const kANSPlistName = @"aaa";

@interface ANSFBFriends ()
@property (nonatomic, strong) NSMutableDictionary *observationHandlers;

- (SEL)selectorForState:(NSUInteger)state;

@end

@implementation ANSFBFriends

#pragma mark -
#pragma mark Private methods (reloaded from super)

- (SEL)selectorForState:(NSUInteger)state {
    switch (state) {
        default:
            return [super selectorForState:state];
    }
}

#pragma mark -
#pragma mark Private Methods

- (id)usersFromFileSystem  {
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *plistPath = [fileManager pathToPlistFile:kANSPlistName inSearchPathDirectory:NSDocumentDirectory];
    
    return [NSKeyedUnarchiver unarchiveObjectWithFile:plistPath];
}

- (id)loadUsersModel {
    sleep(3);
    return  [self usersFromFileSystem];
}

- (void)startObservationForNames:(NSArray <NSString *> *)names
                       withBlock:(ANSExecutableBlock)block {
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    for (NSString *name in names) {
        id observationHandler = [center addObserverForName:name
                                                    object:nil
                                                     queue:[NSOperationQueue mainQueue]
                                                usingBlock:^(NSNotification * _Nonnull note) {
                                                    block();
                                                }];
        
        [self.observationHandlers setObject:observationHandler forKey:name];
    }
}

- (void)stopObservationForNames:(NSArray <NSString *> *)names {
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    for (NSString *name in names) {
        id handler = [self.observationHandlers objectForKey:name];
        [center removeObserver:handler name:name object:nil];
    }
}

- (void)performLoading {
    id users = [self loadUsersModel];
    self.state = users ? ANSLoadableModelDidLoad : ANSLoadableModelDidFailLoading;
}

#pragma mark -
#pragma mark Save and loading(Public methods)

- (void)save {
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *plistPath = [fileManager pathToPlistFile:kANSPlistName inSearchPathDirectory:NSDocumentDirectory];
    BOOL isSuccessfully = [NSKeyedArchiver archiveRootObject:self.objects toFile:plistPath];
    NSLog(@"%@", (isSuccessfully) ? @"saved successfully" : @"save failed");
}

@end
