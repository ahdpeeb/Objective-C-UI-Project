//
//  ANSTestObserver.m
//  Objective-C UI Project
//
//  Created by Nikola Andriiev on 22.08.16.
//  Copyright © 2016 Andriiev.Mykola. All rights reserved.
//

#import "ANSTestObserver.h"

#import "ANSTestObservableObject.h"

@interface ANSTestObserver () <ANSNotificationTest>

@end

@implementation ANSTestObserver

- (void)didCallSelectorForState0:(ANSTestObservableObject *)observableObject {
    NSLog(@"didCallForState0");
}

- (void)didCallSelectorForState1:(ANSTestObservableObject *)observableObject {
    NSLog(@"didCallForState1");
}

- (void)didCallSelectorForState2:(ANSTestObservableObject *)observableObject {
    NSLog(@"didCallForState2");
}

- (void)didCallSelectorForState3:(ANSTestObservableObject *)observableObject {
    NSLog(@"didCallForState3");
}

- (void)didCallSelectorForState4:(ANSTestObservableObject *)observableObject {
    NSLog(@"didCallForState4");
}

@end
