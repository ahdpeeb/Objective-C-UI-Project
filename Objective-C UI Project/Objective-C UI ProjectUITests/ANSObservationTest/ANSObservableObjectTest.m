//
//  ANSObservableObjectTest.m
//  Objective-C UI Project
//
//  Created by Nikola Andriiev on 19.08.16.
//  Copyright © 2016 Andriiev.Mykola. All rights reserved.
//

#import "ANSObservableObjectTest.h"

@implementation ANSObservableObjectTest

- (SEL)selectorForState:(NSUInteger)state {
    switch (state) {
        case ANSFirsState:
            return @selector(didCallFirsState:);
            
        case ANSSecondState:
            return @selector(didCallSecondState:);
            
        case ANSThidsState:
            return @selector(didCallThirdState:);
            
        case ANSFourthState:
            return @selector(didCallFourthState:);
            
        case ANSFifthState:
            return @selector(didCallFiftState:);
            
        default:
            return [super selectorForState:state];
    }
}

@end
