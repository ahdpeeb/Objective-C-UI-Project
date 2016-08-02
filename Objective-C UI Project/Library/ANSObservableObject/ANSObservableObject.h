//
//  ANSObservableObjectTest.h
//  Objective-c course
//
//  Created by Nikola Andriiev on 22.06.16.
//  Copyright © 2016 Anfriiev.Mykola. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ANSProtocolObservationController;
@class ANSBlockObservationController;

@interface ANSObservableObject : NSObject
@property (nonatomic, assign)  NSUInteger state;

//Use this methods for set observation with protocol.
/*Observable object will create ObservationController (for each observer), which will notify
    observer about state changes in observable object*/
//in you subclass you need to define "selectorForState" method
- (ANSProtocolObservationController *)protocolControllerWithObserver:(id)observer;

//Use this methods for set observation with block.
/*Observable object will create ObservationController (for each observer), which will notify
 observer about state changes in observable object*/
- (ANSBlockObservationController *)blockControllerWithObserver:(id)observer;

- (void)setState:(NSUInteger)state withObject:(id)object;

- (BOOL)isObservedByObject:(id)object;

#pragma mark -
#pragma mark Private declaration

//It must be determined directly in observable object.  
//This method is intended for subclasses. Never call it directly.
- (SEL)selectorForState:(NSUInteger)state;

//This method is intended for subclasses. Never call it directly.
- (void)notifyOfStateChange:(NSUInteger)state;
- (void)notifyOfStateChange:(NSUInteger)state withObject:(id)object;

@end
