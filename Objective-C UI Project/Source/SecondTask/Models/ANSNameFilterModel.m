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
- (void)filterByFilterString:(NSString *)filterString;
- (BOOL)isUser:(ANSUser *)user containsString:(NSString *)string;
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
//        [self performBlockWithoutNotification:^{
//            [self addObjectsInRange:model.objects];
//        }]; 
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

- (void)filterByFilterString:(NSString *)filterString {
    [self performBlockWithoutNotification:^{
        [self removeAllObjects];
    }];
    
    for (ANSUser *user in self.model) {
        if (!filterString.length) {
            [self addUserWithoutNotification:user];
        }
        
        if ([self isUser:user containsString:filterString]) {
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

- (BOOL)isUser:(ANSUser *)user containsString:(NSString *)string {
    if (!string) {
        return true;
    }
    
    BOOL value = [user.string rangeOfString:string
                                    options:NSCaseInsensitiveSearch].location == NSNotFound;
    return !value;
}

- (void)verifyObject:(id)object
          withString:(NSString *)string
         performBlock:(ANSOperationBlock)block
{
    if ([object isKindOfClass:[ANSUser class]]) {
        if ([self isUser:(ANSUser *)object containsString:string]) {
            block();
            NSLog(@"верификация успешна");
        }
    }

}

#pragma mark -
#pragma mark Public Methods

- (void)filterModelByfilterString:(NSString *)filterString {
    @synchronized(self) {
        self.filterString = filterString;
        ANSWeakify(self);
        ANSPerformInAsyncQueue(ANSPriorityHigh, ^{
            ANSStrongify(self);
            [self filterByFilterString:filterString];
            NSLog(@"have sorted");
            
            [self notifyOfStateChange:ANSNameFilterModelDidFilter];
        });
    }
}

#pragma mark -
#pragma mark ANSUsersModelObserver

- (void)    arrayModel:(ANSArrayModel *)arrayModel
    didChangeWithModel:(ANSChangeModel *)model
{
    id user = model.userInfo;
    NSString *filterStirng = self.filterString;
    
    switch (model.state) {
        case ANSStateAddObject: {
            [self verifyObject:user withString:filterStirng performBlock:^{
                [self addObject:user];
            }];
            
            break;
        }
        case ANSStateRemoveObject: {
            [self verifyObject:user withString:filterStirng performBlock:^{
                [self removeObject:user];
            }];

            break;
        }
            
        default:
            break;
    }
}

@end
