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
@property (nonatomic, assign) BOOL        shouldNotify;

- (id)controllerWithClass:(Class)cls observer:(id)observer;
- (void)notifyOfStateChange:(NSUInteger)state
                  withBlock:(ANSControllerNotificationBlock)block;

- (void)performBlock:(ANSExecutableBlock)block shouldNotify:(BOOL)shouldNotify;

@end

@implementation ANSObservableObject

@synthesize state = _state;

#pragma mark -
#pragma mark Initialization and deallocation

- (instancetype)init {
    self = [super init];
    self.controllerHashTable = [NSHashTable hashTableWithOptions:NSPointerFunctionsWeakMemory];
    self.shouldNotify = YES; 
    
    return self;
}

#pragma mark -
#pragma mark Accessors

- (void)setState:(NSUInteger)state withUserInfo:(id)UserInfo {
    @synchronized(self) {
        if (_state != state) {
            _state = state;
            
            [self notifyOfStateChange:state withUserInfo:UserInfo];
        }
    }
}

- (void)setState:(NSUInteger)state {
    @synchronized(self) {
        [self setState:state withUserInfo:self];
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

- (void)notifyOfStateChange:(NSUInteger)state
                  withBlock:(ANSControllerNotificationBlock)block
{
    @synchronized(self) {
        if (!block) {
            return;
        }
        
        for (ANSObservationController *controller in self.controllerHashTable) {
            block(controller);
        }
    }
}

- (void)notifyOfStateChange:(NSUInteger)state withUserInfo:(id)UserInfo {
    @synchronized(self) {
        if (self.shouldNotify) {
            [self notifyOfStateChange:(state)
                            withBlock:^(ANSObservationController *controller) {
                                [controller notifyOfStateChange:state withUserInfo:UserInfo];
                            }];
        }
    }
}

- (void)notifyOfStateChange:(NSUInteger)state {
    @synchronized(self) {
        [self notifyOfStateChange:state withUserInfo:nil];
    }
}

- (void)performBlock:(ANSExecutableBlock)block shouldNotify:(BOOL)shouldNotify {
    @synchronized(self) {
        BOOL value = self.shouldNotify;
        self.shouldNotify = shouldNotify;
        
        block();
        
        self.shouldNotify = value;
    }
}

#pragma mark -
#pragma mark Public methods

- (BOOL)isObservedByObject:(id)object {
    @synchronized(self) {
    BOOL value = NO;
        for (ANSObservationController *controler in self.controllerHashTable) {
            value = [object isEqual:controler.observer];
            
            return YES; 
        }

    return value;
        
    }
}

- (ANSProtocolObservationController *)protocolControllerWithObserver:(id)observer {
    Class resultClass = [ANSProtocolObservationController class];
    for (ANSObservationController *controler in self.controllerHashTable) {
        if (controler.observer == observer && [controler isMemberOfClass:resultClass]) {
            return (ANSProtocolObservationController *)controler;
        }
    }
    
    return [self controllerWithClass:[ANSProtocolObservationController class]
                                observer:observer];
}

- (ANSBlockObservationController *)blockControllerWithObserver:(id)observer {

    
    return [self controllerWithClass:[ANSBlockObservationController class]
                                observer:observer];
}

- (void)performBlockWithNotification:(ANSExecutableBlock)block {
    @synchronized(self) {
        [self performBlock:block shouldNotify:YES];
    }
}

- (void)performBlockWithoutNotification:(ANSExecutableBlock)block {
    @synchronized(self) {
        [self performBlock:block shouldNotify:YES];
    }
}

@end
