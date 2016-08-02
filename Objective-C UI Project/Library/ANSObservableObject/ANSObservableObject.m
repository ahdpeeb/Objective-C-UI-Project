//
//  ANSObservableObjectTest.m
//  Objective-c course
//
//  Created by Nikola Andriiev on 22.06.16.
//  Copyright © 2016 Anfriiev.Mykola. All rights reserved.
//

#import "ANSObservableObject.h"

#import "ANSObservationController.h"
#import "ANSBlockObservationController.h"
#import "ANSProtocolObservationController.h"
#import "ANSObservationController+ANSPrivate.h"

@interface ANSObservableObject ()
@property (nonatomic, retain) NSHashTable *controllerHashTable;

- (id)controllerWithClass:(Class)cls observer:(id)observer;

@end

@implementation ANSObservableObject

@synthesize state = _state;

#pragma mark -
#pragma mark Initialization and deallocation

- (instancetype)init {
    self = [super init];
    self.controllerHashTable = [NSHashTable hashTableWithOptions:NSPointerFunctionsStrongMemory];
    
    return self;
}

#pragma mark -
#pragma mark Accessors

- (void)setState:(NSUInteger)state withObject:(id)object {
    @synchronized(self) {
        if (_state != state) {
            _state = state;
            
            [self notifyOfStateChange:state withObject:object];
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

#pragma mark -
#pragma mark Private methods

- (SEL)selectorForState:(NSUInteger)state {
    [self doesNotRecognizeSelector:_cmd];
    
    return NULL;
}

- (void)notifyOfStateChange:(NSUInteger)state withObject:(id)object {
    @synchronized(self) {
        for (ANSObservationController *controller in self.controllerHashTable) {
            [controller notifyOfStateChange:state withObject:object];
        }
    }
}

- (void)notifyOfStateChange:(NSUInteger)state {
    @synchronized(self) {
        [self notifyOfStateChange:state withObject:nil];
    }
}

- (void)invalidateController:(ANSObservationController *)controller {
    @synchronized(self) {
        [self.controllerHashTable removeObject:controller];
    }
}

- (id)controllerWithClass:(Class)cls observer:(id)observer {
    @synchronized(self) {
        ANSObservationController *controller = [cls allocWithObserver:observer
                                                     observableObject:self];
        
        [self.controllerHashTable addObject:controller];
        
        return controller;
    }
}

#pragma mark -
#pragma mark Public methods

//- (void)removeObserverObject:(id)object {
//    @synchronized(self) {
//        [self.observersHashTable removeObject:object];
//    }
//}
//
//- (void)removeObserverObjects:(NSArray *)objects {
//    @synchronized(self) {
//        NSHashTable *observers = self.observersHashTable;
//        for (id observer in objects) {
//            [observers removeObject:observer];
//        }
//    }
//}

- (BOOL)isObservedByObject:(id)object {
    @synchronized(self) {
    BOOL value = NO;
        for (ANSObservationController *controler in self.controllerHashTable) {
            value = [object isEqual:controler.observer];
        }

    return value;
    }
}

- (ANSProtocolObservationController *)protocolControllerWithObserver:(id)observer {
    @synchronized(self) {
        return [self controllerWithClass:[ANSProtocolObservationController class]
                                observer:observer];
    }
}

- (ANSBlockObservationController *)blockControllerWithObserver:(id)observer {
    @synchronized(self) {
        return [self controllerWithClass:[ANSBlockObservationController class]
                                observer:observer];
    }
}

@end
