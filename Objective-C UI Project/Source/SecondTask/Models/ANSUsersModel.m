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
- (ANSUsersModel *)sortUsersByFilterStrirng:(NSString *)filterStrirng;

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


- (ANSUsersModel *)sortUsersByFilterStrirng:(NSString *)filterStrirng {
    ANSUsersModel * users = [ANSUsersModel new];
    for (ANSUser *user in self) {
        if ((filterStrirng.length > 0)
            && [user.string rangeOfString:filterStrirng
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
   __block ANSUsersModel *users = [self copy];
    ANSWeakify(self);
    
    NSBlockOperation *operation= [NSBlockOperation blockOperationWithBlock:^{
       users = [users sortUsersByFilterStrirng:filterStirng];
        NSLog(@"have sorted");
    }];
    
    operation.completionBlock = ^{
        ANSPerformInMainQueue(dispatch_async, ^{
            ANSStrongify(self);
            [self performBlockWithNotification:^{
                [self setState:ANSUsersModelDidfilter withUserInfo:users];
            }];
        });
    };

    self.operation = operation;
}

@end
