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
- (ANSUsersModel *)sortedCollectionByString:(NSString *)filterStrirng;

@end

@implementation ANSUsersModel

#pragma mark -
#pragma mark Accsessors

- (void)loadWithCount:(NSUInteger)count
                block:(ANSObjectBlock)block  {
    ANSPerformInAsyncQueue(ANSPriorityDefault, ^{
        sleep(sleepTime);
        NSArray *objects = [NSArray objectsWithCount:count block:block];
        
        [self addObjects:objects];
        
        ANSPerformInMainQueue(dispatch_async, ^{
            self.state = ANSUsersModelDidLoad;
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


- (ANSUsersModel *)sortedCollectionByString:(NSString *)filterStrirng {
    ANSUsersModel *oldCollection = [self copy];
    ANSUsersModel *newCollection = [[self class] new];
    
    for (ANSUser *user in oldCollection) {
        if ((filterStrirng.length > 0)
            && [user.string rangeOfString:filterStrirng
                                  options:NSCaseInsensitiveSearch].location == NSNotFound) {
                continue;
            } else {
                [newCollection addObject:user];
            }
    }
    
    return newCollection;
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
   __block ANSUsersModel *filteredColllection = nil;
    ANSWeakify(self);
    
    NSBlockOperation *operation= [NSBlockOperation blockOperationWithBlock:^{
        ANSStrongify(self);
        filteredColllection = [self sortedCollectionByString:filterStirng];
        NSLog(@"have sorted");
    }];
    
    operation.completionBlock = ^{
        ANSStrongify(self);
        ANSPerformInMainQueue(dispatch_async, ^{
            [self performBlockWithNotification:^{
                [self setState:ANSUsersModelDidfilter withUserInfo:filteredColllection];
            }];
        });
    };

    self.operation = operation;
}

@end
