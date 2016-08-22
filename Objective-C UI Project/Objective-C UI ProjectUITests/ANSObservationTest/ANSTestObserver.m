//
//  ANSTestObserver.m
//  Objective-C UI Project
//
//  Created by Nikola Andriiev on 22.08.16.
//  Copyright © 2016 Andriiev.Mykola. All rights reserved.
//

#import "ANSTestObserver.h"

#import "ANSObservableObjectTest.h"

@interface ANSTestObserver () <ANSObservationTestProtocol>

@end

@implementation ANSTestObserver

- (void)didCallFirsState:(ANSObservableObjectTest *)observableObject {
    NSLog(@"didCallFirsState");
}

- (void)didCallSecondState:(ANSObservableObjectTest *)observableObject {
    NSLog(@"didCallSecondState");
}

- (void)didCallThirdState:(ANSObservableObjectTest *)observableObject {
    NSLog(@"didCallThirdState");
}

- (void)didCallFourthState:(ANSObservableObjectTest *)observableObject {
    NSLog(@"didCallFourthState");
}

- (void)didCallFiftState:(ANSObservableObjectTest *)observableObject {
    NSLog(@"didCallFiftState");
}

@end
