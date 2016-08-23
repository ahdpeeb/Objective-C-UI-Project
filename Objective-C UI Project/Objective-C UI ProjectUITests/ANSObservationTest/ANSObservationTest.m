//
//  ANSObservationTest.m
//  Objective-C UI Project
//
//  Created by Nikola Andriiev on 19.08.16.
//  Copyright © 2016 Andriiev.Mykola. All rights reserved.
//

#import "Kiwi.h"

#import "ANSTestObservableObject.h"
#import "ANSTestObserver.h"
#import "ANSObservationController.h"

SPEC_BEGIN(ANSObservationTest)

describe(@"ANSObservableObject", ^{
    registerMatchers(@"BG"); // Registers BGTangentMatcher, BGConvexMatcher, etc.
    
    __block ANSTestObservableObject *observableObject = nil;
    __block ANSTestObserver *observer = nil;
    __block id controller = nil;
        
    context(@"a state the component is in", ^{
        beforeAll(^{
            observer = [ANSTestObserver new];
            observableObject = [ANSTestObservableObject new];
            controller = [observableObject protocolControllerWithObserver:observer];
        });
        
        it(@"objects should not be nil", ^{
            [[observer should] beMemberOfClass:[ANSTestObserver class]];
            [[observer shouldNot] beNil];
            [[controller shouldNot] beNil];
            [[observableObject shouldNot] beNil];
        });
        
        it(@"observer should conformsToProtocol ANSObservationTestProtocol", ^{
            [[observer should] conformToProtocol:@protocol(ANSNotificationTest)];
        });
        
        it(@"observer should respond to selectors", ^{
            [[observer should] respondToSelector:@selector(didCallFiftState:)];
            [[observer should] respondToSelector:@selector(didCallSecondState:)];
            [[observer should] respondToSelector:@selector(didCallThirdState:)];
            [[observer should] respondToSelector:@selector(didCallFourthState:)];
            [[observer should] respondToSelector:@selector(didCallFiftState:)];
        });
        
        it(@"should notify only states performed in performBlockWithNotification", ^{
            [observableObject performBlockWithNotification:^{
                [[observer should] receive:@selector(didCallFirsState:)];
                observableObject.state = ANSFifthState;
    
                [observableObject performBlockWithoutNotification:^{
                    [[observer shouldNot] receive:@selector(didCallSecondState:)];
                    observableObject.state = ANSFourthState;
                    
                    [observableObject performBlockWithNotification:^{
                        [[observer should] receive:@selector(didCallThirdState:)];
                        observableObject.state = ANSThidsState;
                     }];
                    
                    [[observer shouldNot] receive:@selector(didCallFourthState:)];
                    observableObject.state = ANSSecondState;
                }];
                
                [[observer should] receive:@selector(didCallFirsState:)];
                observableObject.state = ANSFirsState;
            }];
        });

        
        afterAll(^{ // Occurs once
        });
        
        specify(^{
            [[observer shouldNot] beNil];
            [[controller shouldNot] beNil];
            [[observableObject shouldNot] beNil];
        });
        
        context(@"inner context", ^{
            it(@"does another thing", ^{
            });
        });
    });
});

SPEC_END
