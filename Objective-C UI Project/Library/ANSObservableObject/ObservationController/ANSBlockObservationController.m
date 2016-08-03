//
//  ANSBlockObservationController.m
//  Objective-C UI Project
//
//  Created by Nikola Andriiev on 01.08.16.
//  Copyright © 2016 Andriiev.Mykola. All rights reserved.
//

#import "ANSBlockObservationController.h"

#import "ANSObservableObject+ANSPrivate.h"
#import "ANSObservationController+ANSPrivate.h"

@interface ANSBlockObservationController ()
@property (nonatomic, strong) NSMutableDictionary *stateDictionary;

@end

@implementation ANSBlockObservationController

#pragma mark -
#pragma mark Initialization and dealocation

- (instancetype)initWithObserver:(id)observer
                observableObject:(ANSObservableObject *)observableObject
{
    self = [super initWithObserver:observer observableObject:observableObject];
    if (self) {
        self.stateDictionary = [NSMutableDictionary dictionary];
    }
    
    return self;
}

#pragma mark -
#pragma mark Private methods

- (void)notifyOfStateChange:(NSUInteger)state withUserInfo:(id)userInfo {
    ANSStateChangeBlock block = [self blockForState:state];
    if (block) {
        block(self.observer, self.observableObject, userInfo);
    }
    
}

- (void)notifyOfStateChange:(NSUInteger)state {
    [self notifyOfStateChange:state withUserInfo:nil];
}

#pragma mark -
#pragma mark Public methods

- (void)setBlock:(ANSStateChangeBlock)block forState:(NSUInteger)state {
    if (!block) {
        return;
    }
    
    [self.stateDictionary setObject:[block copy]
                             forKey:@(state)];
}

- (void)removeBlock:(ANSStateChangeBlock)block forState:(NSUInteger)state {
    [self.stateDictionary removeObjectForKey:@(state)];
}

- (ANSStateChangeBlock)blockForState:(NSUInteger)state {
    return [self.stateDictionary objectForKey:@(state)];
}

- (BOOL)containsBlockForState:(NSUInteger)state {
    return nil != [self blockForState:state];
}  

- (ANSStateChangeBlock)objectAtIndexedSubscript:(NSUInteger)index {
    return [self blockForState:index];
}

- (void)setObject:(ANSStateChangeBlock)object atIndexedSubscript:(NSUInteger)index {
    return [self setBlock:object forState:index];
}

@end
