    //
//  ANSNameFilterModel.m
//  Objective-C UI Project
//
//  Created by Nikola Andriiev on 30.08.16.
//  Copyright © 2016 Andriiev.Mykola. All rights reserved.
//

#import "ANSNameFilterModel.h"

#import "ANSProtocolObservationController.h"
#import "ANSUser.h"
#import "ANSGCD.h"
#import "ANSChangeModel.h"
#import "ANSOneIndexModel.h"

#import "ANSMacros.h"

typedef void(^ANSOperationBlock)(void);

@interface ANSNameFilterModel ()
@property (nonatomic, strong)   ANSUsersModel                       *model;
@property (nonatomic, strong)   ANSProtocolObservationController    *controller;
@property (atomic, strong)      NSString                            *filterString;

- (void)addUserWithoutNotification:(ANSUser *)user;
- (void)filterModelByFilterString:(NSString *)filterString;
- (BOOL)user:(ANSUser *)user containsString:(NSString *)string;
- (void)verifyObject:(id)object
          withString:(NSString *)string
         performBlock:(ANSOperationBlock)block;

@end

@implementation ANSNameFilterModel

@dynamic observableObject;

#pragma mark -
#pragma mark Initialization and deadllocation

- (instancetype)initWithObservableModel:(ANSUsersModel *)model {
    self = [super init];
    if (self) {
        self.model = model;
    }
    
    return self;
}

#pragma mark -
#pragma mark Accsessors

- (void)setModel:(ANSUsersModel *)model {
    if (_model != model) {
        _model = model;
        
        self.controller = [model protocolControllerWithObserver:self];
    }
}

- (id)observableModel {
    return self.controller.observableObject;
}

#pragma mark -
#pragma mark Private methods

- (void)addUserWithoutNotification:(ANSUser *)user {
    [self performBlockWithoutNotification:^{
        [self addObject:user];
    }];
}

- (void)filterModelByFilterString:(NSString *)filterString {
    [self performBlockWithoutNotification:^{
        [self removeAllObjects];
    }];
    
    for (ANSUser *user in self.model) {
        if (!filterString.length) {
            [self addUserWithoutNotification:user];
        }
        
        if ([self user:user containsString:filterString]) {
                [self addUserWithoutNotification:user];
        }
    }
    
    NSLog(@"%lu", (unsigned long)self.objects.count);
}

- (SEL)selectorForState:(NSUInteger)state {
    switch (state) {
        case ANSNameFilterModelDidFilter:
            return @selector(nameFilterModelDidFilter:);
            
        default:
            return [super selectorForState:state];
    }
}

- (BOOL)user:(ANSUser *)user containsString:(NSString *)string {
    if (!string) {
        return YES;
    }
    
    NSRange range = [user.name rangeOfString:string
                                  options:NSCaseInsensitiveSearch];
    
    return range.location == NSNotFound;
}

- (void)verifyObject:(id)object
          withString:(NSString *)string
         performBlock:(ANSOperationBlock)block
{
    if ([object isKindOfClass:[ANSUser class]]) {
        if ([self user:(ANSUser *)object containsString:string]) {
            block();
        }
    }
}

#pragma mark -
#pragma mark Public Methods

- (void)filterByfilterString:(NSString *)filterString {
    @synchronized(self) {
        self.filterString = filterString;
        ANSWeakify(self);
        ANSPerformInAsyncQueue(ANSPriorityHigh, ^{
            ANSStrongify(self);
            [self filterModelByFilterString:filterString];
            NSLog(@"have sorted");
            
            [self notifyOfStateChange:ANSNameFilterModelDidFilter];
        });
    }
}

#pragma mark -
#pragma mark ANSUsersModelObserver

- (void)usersModelDidLoad:(ANSUsersModel *)model {
    ANSPerformInAsyncQueue(ANSPriorityLow, ^{
        [self performBlockWithoutNotification:^{
            [self addObjectsInRange:model.objects];
        }];
    });
}

- (void)    arrayModel:(ANSArrayModel *)arrayModel
    didChangeWithModel:(ANSChangeModel *)model
{
    id user = model.userInfo;
    NSString *filterStirng = self.filterString;
    
    [self verifyObject:user withString:filterStirng performBlock:^{
        switch (model.state) {
            case ANSStateAddObject: {
                [self addObject:user];
                break;
            }
            case ANSStateRemoveObject: {
                if ([self containsObject:user]) {
                    [self removeObject:user];
                }
                
                break;
            }
                
            default:
                break;
        }
    }];
}

@end
