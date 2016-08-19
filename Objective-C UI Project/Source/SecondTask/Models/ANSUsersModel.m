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

@interface ANSUsersModel ()
@property (nonatomic, retain) NSOperation *operation;
@property (nonatomic, retain) ANSArrayModel *filteredCollection;

@end

@implementation ANSUsersModel

#pragma mark -
#pragma mark Accsessors

- (void)setOperation:(NSOperation *)operation {
    if (_operation != operation) {
        [_operation cancel];
        
        _operation = operation;
        [_operation start];
    }
}

#pragma mark -
#pragma mark Pricate methods

- (SEL)selectorForState:(NSUInteger)state {
    switch (state) {
        case ANSUsersModelInitWithObjectState:
 //           return @selector(collection:didFilterWithUserInfo:);
        
        case ANSUsersModelFilterdState:
            return @selector(model:didFilterWithUserInfo:);
            
        default:
          return [super selectorForState:state];
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

- (ANSArrayModel *)sortedCollectionByString:(NSString *)filterStrirng {
    ANSArrayModel *newCollection = [ANSArrayModel new];
    for (ANSUser *user in self) {
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

- (void)sortCollectionInBackgroundByString:(NSString *)filterStirng {
    ANSWeakify(self);
    NSBlockOperation *operation = [NSBlockOperation blockOperationWithBlock:^{
        ANSStrongify(self);
        ANSPerformInAsyncQueue(ANSPriorityHigh, ^{
            self.filteredCollection = [self sortedCollectionByString:filterStirng];
        });
    }];
    
    operation.completionBlock = ^{
        ANSStrongify(self);
        ANSPerformInMainQueue(dispatch_async, ^{
            [super performBlockWithNotyfication:^{
                [self setState:ANSUsersModelFilterdState withUserInfo:self.filteredCollection];
            }];
            
        });
    };
    
    self.operation = operation;
}

@end
