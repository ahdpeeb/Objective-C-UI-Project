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

- (void)didCallFirsState:(ANSTestObservableObject *)observableObject;
- (void)didCallSecondState:(ANSTestObservableObject *)observableObject;
- (void)didCallThirdState:(ANSTestObservableObject *)observableObject;
- (void)didCallFourthState:(ANSTestObservableObject *)observableObject;
- (void)didCallFiftState:(ANSTestObservableObject *)observableObject;

@end

typedef NS_ENUM(NSUInteger, ANSState) {
    ANSFirsState,
    ANSSecondState,
    ANSThidsState,
    ANSFourthState,
    ANSFifthState,
};

@interface ANSTestObservableObject : ANSObservableObject

@end
