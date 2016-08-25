//
//  ANSObservableObjectTest.m
//  Objective-C UI Project
//
//  Created by Nikola Andriiev on 19.08.16.
//  Copyright © 2016 Andriiev.Mykola. All rights reserved.
//

#import "ANSTestObservableObject.h"

@implementation ANSTestObservableObject

- (SEL)selectorForState:(NSUInteger)state {
    switch (state) {
        case ANSState0:
            return @selector(didCallSelectorForState0:);
            
        case ANSState1:
            return @selector(didCallSelectorForState1:);
            
        case ANSState2:
            return @selector(didCallSelectorForState2:);
        
        case ANSState3:
            return @selector(didCallSelectorForState3:);
            
        case ANSState4:
            return @selector(didCallSelectorForState4:);
            
        default:
            return [super selectorForState:state];
    }
}

@end
