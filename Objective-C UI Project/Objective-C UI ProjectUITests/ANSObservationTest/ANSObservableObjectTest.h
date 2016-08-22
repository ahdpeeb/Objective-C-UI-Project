//
//  ANSObservableObjectTest.h
//  Objective-C UI Project
//
//  Created by Nikola Andriiev on 19.08.16.
//  Copyright © 2016 Andriiev.Mykola. All rights reserved.
//

#import "ANSObservableObject.h"

@class ANSObservableObjectTest; 

@protocol ANSObservationTestProtocol <NSObject>

@required
- (void)didCallFirsState:(ANSObservableObjectTest *)observableObject;
- (void)didCallSecondState:(ANSObservableObjectTest *)observableObject;
- (void)didCallThirdState:(ANSObservableObjectTest *)observableObject;
- (void)didCallFourthState:(ANSObservableObjectTest *)observableObject;
- (void)didCallFiftState:(ANSObservableObjectTest *)observableObject;

@end

typedef NS_ENUM(NSUInteger, ANSState) {
    ANSFirsState,
    ANSSecondState,
    ANSThidsState,
    ANSFourthState,
    ANSFifthState,
};

@interface ANSObservableObjectTest : ANSObservableObject

@end
