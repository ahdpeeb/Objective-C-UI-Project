//
//  ANSDataCollection.m
//  Objective-C UI Project
//
//  Created by Nikola Andriiev on 24.07.16.
//  Copyright © 2016 Andriiev.Mykola. All rights reserved.
//
#import <UIKit/UIKit.h>

#import "ANSUsersModel.h"

#import "ANSUser.h"
#import "ANSMacros.h"
#import "ANSGCD.h"
#import "NSArray+ANSExtension.h"
#import "NSFileManager+ANSExtension.h"

static const NSUInteger kANSSleepTime = 5;
static const NSUInteger kANSUsersCount = 20;

static NSString * const kANSPlistName = @"aaa";

@interface ANSUsersModel ()
@property (nonatomic, retain) NSOperation *operation;

- (SEL)selectorForState:(NSUInteger)state;
- (void)sortUsersByFilterString:(NSString *)filterString;
- (id)usersFromFileSystem;

@end

@implementation ANSUsersModel

#pragma mark -
#pragma mark Initilization and deallocation 

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.state = ANSUsersModelUnloaded;
    }
    return self;
}

#pragma mark -
#pragma mark Accsessors

- (void)loadWithCount:(NSUInteger)count {
//    ANSPerformInAsyncQueue(ANSPriorityDefault, ^{
//        sleep(sleepTime);
//        NSArray *users = nil;
        [self load];
//        if (!users) {
//            users = [NSArray objectsWithCount:count block:^id{
//                return [ANSUser new];
//            }];
//        }
//
//        [self performBlockWithoutNotification:^{
//            [self addObjectsInRange:users];
//        }];
//        
//        ANSPerformInMainQueue(dispatch_async, ^{
//            [self notifyOfStateChange:ANSUsersModelDidLoad];
//        });
//    });
}

- (void)setOperation:(NSOperation *)operation {
    if (_operation != operation) {
        [_operation cancel];
        
        _operation = operation;
        
        ANSPerformInAsyncQueue(ANSPriorityHigh, ^{
            [operation start];
        });
    }
}

#pragma mark -
#pragma mark Private methods

- (SEL)selectorForState:(NSUInteger)state {
    switch (state) {
        case ANSUsersModelDidLoad:
            return @selector(userModelDidLoad:);
            
        case ANSUsersModelDidfilter:
            return @selector(modeldidFilter:);
            
        default:
          return [super selectorForState:state];
    }
}


- (void)sortUsersByFilterString:(NSString *)filterString {
    NSMutableArray *otherUsers = [NSMutableArray new];
    for (ANSUser *user in self) {
        if ((filterString.length > 0)
            && [user.string rangeOfString:filterString
                                  options:NSCaseInsensitiveSearch].location == NSNotFound) {
                [otherUsers addObject:user];
        }
    }
    [self performBlockWithoutNotification:^{
        for (ANSUser *otherUser in otherUsers) {
            [self removeObject:otherUser];
        }
    }];
}

#pragma mark -
#pragma mark Private Methods

- (id)usersFromFileSystem  {
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *plistPath = [fileManager pathToPlistFile:kANSPlistName inSearchPathDirectory:NSDocumentDirectory];
    
    return [NSKeyedUnarchiver unarchiveObjectWithFile:plistPath];
}

- (id)newUsers {
    return [NSArray objectsWithCount:kANSUsersCount block:^id{
        return [ANSUser new];
    }];
}

#pragma mark -
#pragma mark Public methods

- (NSArray *)descendingSortedUsers {
    NSMutableArray *users = [NSMutableArray arrayWithArray:self.objects];
    [users sortUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        if ([obj1 isKindOfClass:[ANSUser class]] && [obj2 isKindOfClass:[ANSUser class]]) {
             return [[obj1 string] compare:[obj2 string]];
        }
        
        return (NSComparisonResult)NSOrderedDescending;
    }];
    
    return users;
}

- (void)sortCollectionByfilterStirng:(NSString *)filterStirng {
    ANSWeakify(self);
    ANSPerformInAsyncQueue(ANSPriorityHigh, ^{
        ANSStrongify(self);
        [self sortUsersByFilterString:filterStirng];
        NSLog(@"have sorted");
        
        ANSPerformInMainQueue(dispatch_async, ^{
            [self notifyOfStateChange:ANSUsersModelDidfilter];
        });
    });
}

#pragma mark -
#pragma mark Save and loading (Public methods)

- (void)save {
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *plistPath = [fileManager pathToPlistFile:kANSPlistName inSearchPathDirectory:NSDocumentDirectory];
    BOOL isSuccessfully = [NSKeyedArchiver archiveRootObject:self.objects toFile:plistPath];
    NSLog(@"%@", (isSuccessfully) ? @"saved successfully" : @"save failed");
}

- (void)load {
    ANSUserLoadingState state = self.state;
    if (state == ANSUsersModelLoading || state == ANSUsersModelDidLoad) {
        [self notifyOfStateChange:state];
        return;
    }
    
    if (state == ANSUsersModelUnloaded || state == ANSUsersModelDidFailLoading) {
        self.state = ANSUsersModelLoading;
        ANSWeakify(self);
        ANSPerformInAsyncQueue(ANSPriorityHigh, ^{
            ANSStrongify(self);
            id users = [self usersFromFileSystem];
            if (!users) {
                users = [self usersFromFileSystem];
            }
            
            sleep(kANSSleepTime);
            if (!users) {
                ANSPerformInMainQueue(dispatch_async, ^{
                    self.state = ANSUsersModelDidFailLoading;
                    return;
                });
            }
            
            [self performBlockWithoutNotification:^{
                [self addObjectsInRange:users];
            }];
            
            ANSPerformInMainQueue(dispatch_async, ^{
                self.state = ANSUsersModelDidLoad;
                return;
            });
        });
    }
}

@end
