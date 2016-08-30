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

#import "ANSMacros.h"

@interface ANSNameFilterModel ()
@property (nonatomic, weak) id <ANSArrayModelObserver> model;
@property (nonatomic, strong) ANSProtocolObservationController  *controller;

@end

@implementation ANSNameFilterModel

@synthesize objects = _objects;

@dynamic observableObject;

#pragma mark -
#pragma mark Initialization and deadllocation

- (instancetype)initWithObservableModel:(id <ANSArrayModelObserver>)model  {
    self = [super init];
    if (self) {
        self.model = model;
    }
    
    return self;
}

#pragma mark -
#pragma mark Accsessors

- (void)setModel:(id<ANSArrayModelObserver>)model {
    if (_model != model) {
        _model = model;
    }
    
    self.controller = [(ANSArrayModel *)model protocolControllerWithObserver:self];
}

- (id)observableModel {
    return self.controller.observableObject;
}

#pragma mark -
#pragma mark Private methods

- (void)sortUsersByFilterString:(NSString *)filterString {
    NSMutableArray *filteredUsers = [NSMutableArray new];
    ANSArrayModel *model = (ANSArrayModel *)self.model;
    
    for (ANSUser *user in model.objects) {
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

#pragma mark -
#pragma mark public Methods

- (void)sortCollectionByfilterStrirng:(NSString *)filterStrirng {
    ANSWeakify(self);
    ANSPerformInAsyncQueue(ANSPriorityHigh, ^{
        ANSStrongify(self);
        [self sortUsersByFilterString:filterStrirng];
        NSLog(@"have sorted");
        
        [self notifyOfStateChange:ANSUsersModelDidfilter];
    });
}


@end
