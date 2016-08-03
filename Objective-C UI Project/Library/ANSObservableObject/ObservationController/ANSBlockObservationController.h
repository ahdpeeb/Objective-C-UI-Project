//
//  ANSBlockObservationController.h
//  Objective-C UI Project
//
//  Created by Nikola Andriiev on 01.08.16.
//  Copyright © 2016 Andriiev.Mykola. All rights reserved.
//

#import "ANSObservationController.h"

typedef void(^ANSStateChangeBlock)(id observer, id observableObject);

@interface ANSBlockObservationController : ANSObservationController

- (void)setBlock:(ANSStateChangeBlock)block forState:(NSUInteger)state;
- (void)removeBlock:(ANSStateChangeBlock)block forState:(NSUInteger)state;

- (BOOL)containsBlockForState:(NSUInteger)state;
- (ANSStateChangeBlock)blockForState:(NSUInteger)state;

#pragma mark -
#pragma mark Block observation methods

//block calls for all states
- (void)addObserverObject:(id)object
                withBlock:(ANSStateChangeBlock)block;

//block calls for particular state
- (void)addObserverObject:(id)object
                 forState:(NSUInteger)state
                withBlock:(ANSStateChangeBlock)block;

//block calls for some states
- (void)addObserverObject:(id)object
         forStatesInRange:(NSUInteger)stateCount
                withBlock:(ANSStateChangeBlock)block;

// remove observer for particular state
- (void)removeObserverObject:(id)object
                    forState:(NSUInteger)state
                   withBlock:(ANSStateChangeBlock)block;

- (void)addStateChangeBlock:(ANSStateChangeBlock)block;
- (void)removeStateChangeBlock:(ANSStateChangeBlock)block;
- (void)isObserveByBlock:(ANSStateChangeBlock)block;

- (ANSStateChangeBlock)objectAtIndexedSubscript:(NSUInteger)index;
- (void)setObject:(ANSStateChangeBlock)object atIndexedSubscript:(NSUInteger)index;

@end
