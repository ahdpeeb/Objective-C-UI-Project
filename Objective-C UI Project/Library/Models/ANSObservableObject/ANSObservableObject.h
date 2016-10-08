//
//  ANSObservableObjectTest.h
//  Objective-c course
//
//  Created by Nikola Andriiev on 22.06.16.
//  Copyright © 2016 Anfriiev.Mykola. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "ANSObservableObjectPtotocol.h"

@class ANSObservationController;
@class ANSProtocolObservationController;
@class ANSBlockObservationController;

typedef void(^ANSControllerNotificationBlock)(ANSObservationController *controller);

@interface ANSObservableObject : NSObject <NSCopying, ANSObservableObjectPtotocol>
@property (atomic, assign)                       NSUInteger state;

- (instancetype)initWithTarget:(id)target NS_DESIGNATED_INITIALIZER;

@end
