//
//  ANSObservableObjectTest.h
//  Objective-C UI Project
//
//  Created by Nikola Andriiev on 19.08.16.
//  Copyright © 2016 Andriiev.Mykola. All rights reserved.
//

#import "ANSObservableObject.h"

@class ANSTestObservableObject; 

@protocol ANSNotificationTest <NSObject>

- (void)didCallSelectorForState0:(ANSTestObservableObject *)observableObject;
- (void)didCallSelectorForState1:(ANSTestObservableObject *)observableObject;
- (void)didCallSelectorForState2:(ANSTestObservableObject *)observableObject;
- (void)didCallSelectorForState3:(ANSTestObservableObject *)observableObject;
- (void)didCallSelectorForState4:(ANSTestObservableObject *)observableObject;

@end

typedef NS_ENUM(NSUInteger, ANSState) {
    ANSState0,
    ANSState1,
    ANSState2,
    ANSState3,
    ANSState4,
};

@interface ANSTestObservableObject : ANSObservableObject

@end
