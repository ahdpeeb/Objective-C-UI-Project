//
//  ANSObservableObjectTest.m
//  Objective-c course
//
//  Created by Nikola Andriiev on 22.06.16.
//  Copyright © 2016 Anfriiev.Mykola. All rights reserved.
//

#import "ANSObservableObject.h"

@interface ANSObservableObject ()
@property (nonatomic, retain) NSHashTable *observersHashTable;

@end

@implementation ANSObservableObject

@synthesize state = _state;

@dynamic observersSet;

#pragma mark -
#pragma mark Initialization and deallocation

- (instancetype)init {
    self = [super init];
    self.observersHashTable = [NSHashTable hashTableWithOptions:NSPointerFunctionsWeakMemory];
    
    return self;
}

#pragma mark -
#pragma mark Accessors

- (void)setState:(NSUInteger)state withObject:(id)object {
    @synchronized(self) {
        if (_state != state) {
            _state = state;
            
            [self notifyObserversWithSelector:[self selectorForState:state] object:object];
        }
    }
}

- (void)setState:(NSUInteger)state {
    @synchronized(self) {
        [self setState:state withObject:self];
    }
}

- (NSUInteger)state {
    @synchronized(self) {
        return _state;
    }
}

- (NSSet *)observersSet {
    @synchronized(self) {
        return self.observersHashTable.setRepresentation;
    }
}

#pragma mark -
#pragma mark Public methods (protocol observation)

- (void)addObserverObject:(id)object {
    @synchronized(self) {
        [self.observersHashTable addObject:object];
    }
}

- (void)addObserverObjects:(NSArray *)objects {
    @synchronized(self) {
        NSHashTable *observers = self.observersHashTable;
        if (!objects) {
            return;
        }
            
        for (id object in objects) {
            [observers addObject:object];
        }
    }
}

- (void)removeObserverObject:(id)object {
    @synchronized(self) {
        [self.observersHashTable removeObject:object];
    }
}

- (void)removeObserverObjects:(NSArray *)objects {
    @synchronized(self) {
        NSHashTable *observers = self.observersHashTable;
        for (id observer in objects) {
            [observers removeObject:observer];
        }
    }
}

- (BOOL)isObservedByObject:(id)object {
    @synchronized(self) {
        return [self.observersHashTable containsObject:object];
    }
}

#pragma mark -
#pragma mark Public methods (block observation)

- (void)addObserverObject:(id)object
                withBlock:(ANSStateChangeBlock)block
{

}

- (void)addObserverObject:(id)object
                withBlock:(ANSStateChangeBlock)block
                 forState:(NSUInteger)state
{

}

- (void)removeObserverObject:(id)object
                   withBlock:(ANSStateChangeBlock)block
                    forState:(NSUInteger)state
{
    
}

#pragma mark -
#pragma mark Private methods

- (SEL)selectorForState:(NSUInteger)state {
    return NULL;
}

- (void)notifyObserversWithSelector:(SEL)selector object:(id)object {
    @synchronized(self) {
        NSHashTable *observers = self.observersHashTable;
        for (id observer in observers) {
            if ([observer respondsToSelector:selector]) {
                [observer performSelector:selector withObject:self withObject:object];
            }
        }
    }
}
    
- (void)notifyObserversWithSelector:(SEL)selector {
    [self notifyObserversWithSelector:selector object:self];
}

- (void)notifyOfStateChange:(NSUInteger)state withObject:(id)object {
    @synchronized(self) {
        SEL selector = [self selectorForState:state];
        [self notifyObserversWithSelector:selector object:object];
    }
}

- (void)notifyOfStateChange:(NSUInteger)state {
    [self notifyOfStateChange:state withObject:nil];
}

@end
