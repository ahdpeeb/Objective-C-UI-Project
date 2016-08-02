//
//  ANSObservableObjectTest.h
//  Objective-c course
//
//  Created by Nikola Andriiev on 22.06.16.
//  Copyright © 2016 Anfriiev.Mykola. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^ANSStateChangeBlock)(id observer, id observableObject);

@interface ANSObservableObject : NSObject
@property (atomic, assign)          NSUInteger    state;
@property (nonatomic, readonly)     NSSet         *observersSet;

- (void)setState:(NSUInteger)state withObject:(id)object;

- (void)addObserverObject:(id)object;
- (void)addObserverObjects:(NSArray *)objects;
- (void)removeObserverObject:(id)object;
- (void)removeObserverObjects:(NSArray *)objects;
- (BOOL)isObservedByObject:(id)object;

//This method is intended for subclasses. Never call it directly.
- (void)notifyOfStateChange:(NSUInteger)state;
- (void)notifyOfStateChange:(NSUInteger)state withObject:(id)object;

//This method is intended for subclasses. Never call it directly.
//It must be determined directly in observable object.  
- (SEL)selectorForState:(NSUInteger)state;

- (void)notifyObserversWithSelector:(SEL)selector;
- (void)notifyObserversWithSelector:(SEL)selector object:(id)object;

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

@end
