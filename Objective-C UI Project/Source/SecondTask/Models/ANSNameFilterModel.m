    //
//  ANSNameFilterModel.m
//  Objective-C UI Project
//
//  Created by Nikola Andriiev on 30.08.16.
//  Copyright © 2016 Andriiev.Mykola. All rights reserved.
//

#import "ANSNameFilterModel.h"

#import "ANSProtocolObservationController.h"
#import "ANSFaceBookUser.h"
#import "ANSGCD.h"
#import "ANSChangeModel.h"
#import "ANSOneIndexModel.h"

#import "ANSMacros.h"

typedef void(^ANSOperationBlock)(void);

@interface ANSNameFilterModel ()
@property (nonatomic, strong)   ANSFaceBookFriends                  *model;
@property (nonatomic, strong)   ANSProtocolObservationController    *controller;
@property (atomic, strong)      NSString                            *filterString;

- (void)addUserWithoutNotification:(ANSFaceBookUser *)user;
- (void)filterModelByFilterString:(NSString *)filterString;
- (BOOL)user:(ANSFaceBookUser *)user containsString:(NSString *)string;
- (void)verifyObject:(id)object
          withString:(NSString *)string
         performBlock:(ANSOperationBlock)block;

@end

@implementation ANSNameFilterModel

@dynamic observableObject;

#pragma mark -
#pragma mark Initialization and deadllocation

- (instancetype)initWithObservableModel:(id)model {
    self = [super init];
    if (self) {
        self.model = model;
    }
    
    return self;
}

#pragma mark -
#pragma mark Accsessors

- (void)setModel:(ANSFaceBookFriends *)model {
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

- (void)addUserWithoutNotification:(ANSFaceBookUser *)user {
    [self performBlockWithoutNotification:^{
        [self addObject:user];
    }];
}

- (void)filterModelByFilterString:(NSString *)filterString {
    [self performBlockWithoutNotification:^{
        [self removeAllObjects];
    }];
    
    for (ANSFaceBookUser *user in self.model) {
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

- (BOOL)user:(ANSFaceBookUser *)user containsString:(NSString *)string {
    if (!string) {
        return YES;
    }
    
    NSRange range = [user.fullName rangeOfString:string
                                  options:NSCaseInsensitiveSearch];
    
    return range.location == NSNotFound;
}

- (void)verifyObject:(id)object
          withString:(NSString *)string
         performBlock:(ANSOperationBlock)block
{
    if ([object isKindOfClass:[ANSFaceBookUser class]]) {
        if ([self user:(ANSFaceBookUser *)object containsString:string]) {
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

- (void)usersModelDidLoad:(ANSFaceBookFriends *)model {
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
