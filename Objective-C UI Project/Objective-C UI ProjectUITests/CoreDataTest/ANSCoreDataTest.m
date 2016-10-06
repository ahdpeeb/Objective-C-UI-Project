//
//  ANSCoreDataTest.m
//  Objective-C UI Project
//
//  Created by Nikola Andriiev on 06.10.16.
//  Copyright © 2016 Andriiev.Mykola. All rights reserved.
//
#import <CoreData/CoreData.h>

#import "Kiwi.h"

#import "ANSTestUser.h"

#import "ANSCoreDataManager.h"
#import "NSManagedObject+ANSExtension.h"
#import "NSManagedObjectContext+Extension.h"
#import "NSFileManager+ANSExtension.h"

@class DBTestUSer;

SPEC_BEGIN(ANSCoreDataTest);

describe(@"coreDataTest", ^{
    __block ANSCoreDataManager *sharedManager = nil;
    registerMatchers(@"bla");
    context(@"Generate NSManagedObject users", ^{
        for (NSUInteger value = 0; value < 100; value ++) {
            ANSTestUser *user = [ANSTestUser randomUser];
            NSManagedObject *object = [sharedManager.managedObjectContext managedObjectWithClass:[ANSTestUser class]];
            NSLog(@"object - %@", object);
            [object setValue:user.firsName forKey:@"firsName"];
        }
    }); 
    
    beforeAll(^{
        sharedManager = [[ANSCoreDataManager alloc] initWithMomName:@"ANSCoreDataModel"];
    });
    
    beforeEach(^{
        
    });
    
    it(@"sharedManager ans it's ", ^{
        [[sharedManager shouldNot] beNil];
        
        [[sharedManager.managedObjectModel shouldNot] beNil];
        [[sharedManager.persistentStoreCoordinator shouldNot] beNil];
        [[sharedManager.managedObjectContext shouldNot] beNil];
        NSLog(@"%@", sharedManager);
    });
    
    it(@"bla 1", ^{

    });
    
    it(@"bla 2", ^{

    });
    
    it(@"bla 3", ^{

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
