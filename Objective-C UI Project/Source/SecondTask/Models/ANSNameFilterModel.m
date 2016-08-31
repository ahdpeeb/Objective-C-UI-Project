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

@interface ANSNameFilterModel ()
@property (nonatomic, strong) ANSUsersModel *model;
@property (nonatomic, strong) ANSProtocolObservationController  *controller;
@property (atomic, strong)    NSString *filterString;

- (void)filterByFilterString:(NSString *)filterString;

@end

@implementation ANSNameFilterModel

@dynamic observableObject;

#pragma mark -
#pragma mark Initialization and deadllocation

- (instancetype)initWithObservableModel:(ANSUsersModel *)model {
    self = [super init];
    if (self) {
        self.model = model;
        [self addObjectsInRange:model.objects];
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

- (void)filterByFilterString:(NSString *)filterString {
    NSMutableArray *filteredUsers = [NSMutableArray new];
    for (ANSUser *user in self.model) {
        if ((filterString.length > 0)
            && [user.string rangeOfString:filterString
                                  options:NSCaseInsensitiveSearch].location == NSNotFound) {
                [filteredUsers addObject:user];
        }
    }
    
    [self performBlockWithoutNotification:^{
        for (ANSUser *filteredUser in filteredUsers) {
            [self removeObject:filteredUser];
        }
    }];
}

- (SEL)selectorForState:(NSUInteger)state {
    switch (state) {
        case ANSNameFilterModelDidFilter:
            return @selector(nameFilterModelDidFilter:);
            
        default:
            return [super selectorForState:state];
    }
}

#pragma mark -
#pragma mark Public Methods

- (void)filterModelByfilterStrirng:(NSString *)filterStrirng {
    @synchronized(self) {
        self.filterString = filterStrirng;
        ANSWeakify(self);
        ANSPerformInAsyncQueue(ANSPriorityHigh, ^{
            ANSStrongify(self);
            [self filterByFilterString:filterStrirng];
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
    ANSOneIndexModel *indexModel = (ANSOneIndexModel *)model;
    NSUInteger index = indexModel.index;
    switch (model.state) {
        case ANSStateAddObject: {
            id object = arrayModel[index];
            if ([object isKindOfClass:[ANSUser class]]) {
                [self insertObject:object atIndex:index];
            }
            
            [self filterModelByfilterStrirng:self.filterString];
            break;
        }
        case ANSStateRemoveObject:
            [self removeObjectAtIndex:index];
            [self filterModelByfilterStrirng:self.filterString];
            break;
            
        default:
            break;
    }
}

@end
