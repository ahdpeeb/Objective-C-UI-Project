//
//  ANSObservationTest.m
//  Objective-C UI Project
//
//  Created by Nikola Andriiev on 19.08.16.
//  Copyright © 2016 Andriiev.Mykola. All rights reserved.
//

#import "Kiwi.h"

#import "ANSObservableObjectTest.h"
#import "ANSTestObserver.h"
#import "ANSObservationController.h"

SPEC_BEGIN(ANSObservationTest)

describe(@"ANSPbservableObject", ^{
    registerMatchers(@"BG"); // Registers BGTangentMatcher, BGConvexMatcher, etc.
    
    __block ANSObservableObjectTest *observableObject = nil;
    __block ANSTestObserver *observer = nil;
    __block id controller = nil;
        
    context(@"a state the component is in", ^{

        beforeAll(^{ // Occurs once
            observer = [ANSTestObserver new];
            observableObject = [ANSObservableObjectTest new];
            
            controller = [observableObject protocolControllerWithObserver:observer];
        });
        
        it(@"objects should not be nil", ^{
            [[observer should] beMemberOfClass:[ANSTestObserver class]];
            [[observer shouldNot] beNil];
            [[controller shouldNot]beNil];
            [[observableObject shouldNot] beNil];
        });
        
        it(@"observer should conformsToProtocol ANSObservationTestProtocol", ^{
            [[observer should] conformsToProtocol:@protocol(ANSObservationTestProtocol)];
        });
        
        it(@"observer should respond to selectors", ^{
            [[observer should] respondsToSelector:@selector(didCallFirsState:)];
            [[observer should] respondsToSelector:@selector(didCallSecondState:)];
            [[observer should] respondsToSelector:@selector(didCallThirdState:)];
            [[observer should] respondsToSelector:@selector(didCallFourthState:)];
            [[observer should] respondsToSelector:@selector(didCallFiftState:)];
            
        });
        
        it(@"should notify only states performed in performBlockWithNotification", ^{
            [observableObject performBlockWithNotification:^{
                observableObject.state = ANSFifthState;
                [[observer should]receive:@selector(didCallFiftState:)];
                
                [observableObject performBlockWithoutNotification:^{
                    observableObject.state = ANSFourthState;
                    [[observer shouldNot]receive:@selector(didCallSecondState:)];
                    
                    [observableObject performBlockWithNotification:^{
                        observableObject.state = ANSThidsState;
                        [[observer should]receive:@selector(didCallThirdState:)];
                     }];
                    
                    observableObject.state = ANSSecondState;
                    [[observer shouldNot]receive:@selector(didCallFourthState:)];
                }];
                
                observableObject.state = ANSFirsState;
                [[observer should]receive:@selector(didCallFirsState:)];
            }];
        });

        
        afterAll(^{ // Occurs once
        });
        
        specify(^{
            [[observer shouldNot] beNil];
            [[controller shouldNot]beNil];
            [[observableObject shouldNot] beNil];
        });
        
        context(@"inner context", ^{
            it(@"does another thing", ^{
            });
            
        });
    });
});

SPEC_END
