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

static const NSUInteger sleepTime = 5;

@interface ANSUsersModel ()
@property (nonatomic, retain) NSOperation *operation;

- (SEL)selectorForState:(NSUInteger)state;
- (ANSUsersModel *)sortUsersByFilterString:(NSString *)filterString;

@end

@implementation ANSUsersModel

#pragma mark -
#pragma mark Accsessors

- (void)loadWithCount:(NSUInteger)count {
    ANSPerformInAsyncQueue(ANSPriorityDefault, ^{
        sleep(sleepTime);
        NSArray *users;
        users = [self loadState];
        if (!users) {
            users = [NSArray objectsWithCount:count block:^id{
                return [ANSUser new];
            }];
        }

        [self performBlockWithoutNotification:^{
            [self addObjects:users];
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
            return @selector(model:didFilterWithUserInfo:);
            
        default:
          return [super selectorForState:state];
    }
}


- (ANSUsersModel *)sortUsersByFilterString:(NSString *)filterString {
    ANSUsersModel * users = [ANSUsersModel new];
    for (ANSUser *user in self) {
        if ((filterString.length > 0)
            && [user.string rangeOfString:filterString
                                  options:NSCaseInsensitiveSearch].location == NSNotFound) {
                continue;
            } else {
                [users addObject:user];
            }
    }
    
    return users;
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
    __block ANSUsersModel *users = nil;
    ANSWeakify(self);
    
    ANSPerformInAsyncQueue(ANSPriorityHigh, ^{
        ANSStrongify(self);
        users = [self sortUsersByFilterString:filterStirng];
        NSLog(@"have sorted");
        
        ANSPerformInMainQueue(dispatch_async, ^{
            ANSStrongify(self);
            [self performBlockWithNotification:^{
                [self notifyOfStateChange:ANSUsersModelDidfilter withUserInfo:users];
            }];
        });
    });
}

@end
