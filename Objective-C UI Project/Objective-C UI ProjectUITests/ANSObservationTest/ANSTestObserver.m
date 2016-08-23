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

- (void)didCallFirsState:(ANSTestObservableObject *)observableObject {
    NSLog(@"didCallFirsState");
}

- (void)didCallSecondState:(ANSTestObservableObject *)observableObject {
    NSLog(@"didCallSecondState");
}

- (void)didCallThirdState:(ANSTestObservableObject *)observableObject {
    NSLog(@"didCallThirdState");
}

- (void)didCallFourthState:(ANSTestObservableObject *)observableObject {
    NSLog(@"didCallFourthState");
}

- (void)didCallFiftState:(ANSTestObservableObject *)observableObject {
    NSLog(@"didCallFiftState");
}

@end
