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

static const NSUInteger sleepTime = 5;

static NSString * const kANSPlistName = @"aaa";

@interface ANSUsersModel ()
@property (nonatomic, retain) NSOperation *operation;

- (SEL)selectorForState:(NSUInteger)state;
- (void)sortUsersByFilterString:(NSString *)filterString;

@end

@implementation ANSUsersModel

#pragma mark -
#pragma mark Accsessors

- (void)loadWithCount:(NSUInteger)count {
    if (self.isLoaded) {
        return;
    }
    
    ANSPerformInAsyncQueue(ANSPriorityDefault, ^{
        sleep(sleepTime);
        NSArray *users = nil;
        users = [self load];
        if (!users) {
            users = [NSArray objectsWithCount:count block:^id{
                return [ANSUser new];
            }];
        }

        [self performBlockWithoutNotification:^{
            [self addObjectsInRange:users];
        }];
        
        ANSPerformInMainQueue(dispatch_async, ^{
            [self notifyOfStateChange:ANSUsersModelDidLoad];
        });
    });
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
    
    for (ANSUser *otherUser in otherUsers) {
    [self performBlockWithoutNotification:^{
        [self removeObject:otherUser];
    }];
        
    }
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
            [self performBlockWithNotification:^{
                [self notifyOfStateChange:ANSUsersModelDidfilter];
            }];
        });
    });
}

#pragma mark -
#pragma mark Save and loading (Public methods)

- (void)save {
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *plistPath = [fileManager pathToPlistFile:kANSPlistName inDirectory:NSDocumentDirectory];
    BOOL isSuccessfully = [NSKeyedArchiver archiveRootObject:self.objects toFile:plistPath];
    NSLog(@"%@", (isSuccessfully) ? @"saved successfully" : @"save failed");
}

- (id)load {
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *plistPath = [fileManager pathToPlistFile:kANSPlistName inDirectory:NSDocumentDirectory];
 
    return [NSKeyedUnarchiver unarchiveObjectWithFile:plistPath];
}

@end
