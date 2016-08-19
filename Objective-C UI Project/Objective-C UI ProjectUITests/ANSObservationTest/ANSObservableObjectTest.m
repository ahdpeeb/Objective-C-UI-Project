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
    switch (self.state) {
        case ANSFirsState:
            return @selector(didUpdate:);
            
        case ANSSecondState:
            return @selector(didUpdate:);
            
        case ANSThidsState:
            return @selector(didUpdate:);
            
        case ANSFourthState:
            return @selector(didUpdate:);
            
        case ANSFifthState:
            return @selector(didUpdate:);
            
        default:
            return [super selectorForState:state];
    }
}

@end
