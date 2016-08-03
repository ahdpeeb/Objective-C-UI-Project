//
//  _ANSObservationController.h
//  Objective-C UI Project
//
//  Created by Nikola Andriiev on 01.08.16.
//  Copyright © 2016 Andriiev.Mykola. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "ANSObservableObject.h"

@interface ANSObservationController : NSObject
@property (nonatomic, readonly)                 id                  observer;
@property (nonatomic, readonly)                 ANSObservableObject *observableObject;
@property (nonatomic, readonly, getter=isValid) BOOL                valid;

+ (instancetype)allocWithObserver:(id)observer
                 observableObject:(ANSObservableObject *)observableObject;

- (instancetype)initWithObserver:(id)observer
                observableObject:(ANSObservableObject *)observableObject;

// it will be removed from observable object at some point
- (void)invalidate;

@end
