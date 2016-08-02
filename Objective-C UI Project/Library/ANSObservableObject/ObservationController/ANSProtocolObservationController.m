//
//  ANSProtocolObservationController.m
//  Objective-C UI Project
//
//  Created by Nikola Andriiev on 01.08.16.
//  Copyright © 2016 Andriiev.Mykola. All rights reserved.
//

#import "ANSProtocolObservationController.h"

#import "ANSObservationController+ANSPrivate.h"

@interface ANSProtocolObservationController ()

- (void)notifyObserversWithSelector:(SEL)selector;
- (void)notifyObserversWithSelector:(SEL)selector object:(id)object;

@end

@implementation ANSProtocolObservationController

#pragma mark -
#pragma mark Private Methods

- (void)notifyOfStateChange:(NSUInteger)state withObject:(id)object {
    [self notifyObserversWithSelector:[self.observableObject selectorForState:state] object:object];
}

- (void)notifyOfStateChange:(NSUInteger)state {
    [self notifyOfStateChange:state withObject:nil];
}

- (void)notifyObserversWithSelector:(SEL)selector object:(id)object {
    id observer = self.observer;
    
    if ([observer respondsToSelector:selector]) {
        [observer performSelector:selector withObject:self.observableObject withObject:object];
    }
}

- (void)notifyObserversWithSelector:(SEL)selector {
    [self notifyObserversWithSelector:selector object:self.observableObject];
}

@end
