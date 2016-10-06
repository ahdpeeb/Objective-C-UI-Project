//
//  ANSCoreDataTest.m
//  Objective-C UI Project
//
//  Created by Nikola Andriiev on 06.10.16.
//  Copyright © 2016 Andriiev.Mykola. All rights reserved.
//
#import <CoreData/CoreData.h>

#import "Kiwi.h"

#import "ANSCoreDataManager.h"
#import "NSManagedObject+ANSExtension.h"
#import "NSManagedObjectContext+Extension.h"

SPEC_BEGIN(ANSCoreDataTest);

describe(@"coreDataTest", ^{
    __block ANSCoreDataManager *sharedManager = nil;
    registerMatchers(@"bla");
    context(@"", ^{
    
    });
    
    beforeAll(^{
       sharedManager = [ANSCoreDataManager sharedManagerWithMomName:@"ANSCoreDataModel"];
    });
    
    beforeEach(^{
        
    });
    
    it(@"bla lba ", ^{
        ANSCoreDataManager *manager = [ANSCoreDataManager sharedManager];
        [[manager shouldNot] beNil]; 
    });
    
    it(@"bla bla", ^{

    });
    
    it(@"bla bla", ^{

    });
    
    it(@"bla lba", ^{

    });

    afterEach(^{
    });
    
    afterAll(^{
    });
    
    specify(^{
    });
    
    context(@"inner context", ^{
        it(@"does another thing", ^{
        });
        
    });
});

SPEC_END
