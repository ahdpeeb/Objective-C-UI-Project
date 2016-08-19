//
//  ANSObservationTest.m
//  Objective-C UI Project
//
//  Created by Nikola Andriiev on 19.08.16.
//  Copyright © 2016 Andriiev.Mykola. All rights reserved.
//

#import "Kiwi.h"

#import "ANSObservableObjectTest.h"

SPEC_BEGIN(ANSObservationTest)

describe(@"ClassName", ^{
    registerMatchers(@"BG"); // Registers BGTangentMatcher, BGConvexMatcher, etc.
    
    __block ANSObservableObjectTest *observableObject;
    __block NSObject *observer;
    __block id controller; ;
    
    context(@"a state the component is in", ^{

        beforeAll(^{ // Occurs once
            observer = [NSObject new];
            observableObject = [ANSObservableObjectTest new];
            
            controller = [observableObject protocolControllerWithObserver:observer];
        });
        
        it(@"observer should respond", ^{
            [[observer should]respondsToSelector:@selector(didUpdate:)];
        });
        
        it(@"should notify only states performed in performBlockWithNotyfication", ^{
            [observableObject performBlockWithNotyfication:^{
                observableObject.state = ANSFifthState;
                 [[observer should]receive:@selector(didUpdate:)];
                
                [observableObject performBlockWithoutNotyfication:^{
                    observableObject.state = ANSFourthState;
                    [[observer shouldNot]receive:@selector(didUpdate:)];
                    
                    [observableObject performBlockWithNotyfication:^{
                        observableObject.state = ANSThidsState;
                        [[observer should]receive:@selector(didUpdate:)];
                     }];
                    
                    observableObject.state = ANSSecondState;
                    [[observer shouldNot]receive:@selector(didUpdate:)];
                }];
                
                observableObject.state = ANSFirsState;
                [[observer should]receive:@selector(didUpdate:)];
            }];
        });
        
        it(@"controller should not be nil", ^{
            [[controller shouldNot]beNil]; 
        });
        
        it(@"observer should conformsToProtocol ANSObservationTestProtocol", ^{
            [[observer shouldNot]conformsToProtocol:@protocol(ANSObservationTestProtocol)];
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
