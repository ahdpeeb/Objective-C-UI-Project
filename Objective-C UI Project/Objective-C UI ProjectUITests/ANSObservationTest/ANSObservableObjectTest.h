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

- (void)didUpdate:(ANSObservableObjectTest *)observableObject;

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
