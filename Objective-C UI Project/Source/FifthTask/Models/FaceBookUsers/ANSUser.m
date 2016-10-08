//
//  ANSUser.m
//  Objective-C UI Project
//
//  Created by Nikola Andriiev on 07.10.16.
//  Copyright © 2016 Andriiev.Mykola. All rights reserved.
//

#import "ANSUser.h"

#import "ANSRandom.h"
#import "NSString+ANSExtension.h"
#import "NSManagedObject+ANSExtension.h"
#import "ANSObservableObject.h"

@interface ANSUser ()
@property (nonatomic, strong) ANSObservableObject *userObservationTarget;

@end

@implementation ANSUser

@synthesize userObservationTarget;

@synthesize fullName;
@synthesize imageUrl;

- (instancetype)init {
    self = [super init];
    if (self) {
        self.userObservationTarget = [[ANSObservableObject alloc] initWithTarget:self];
    }
    
    return self;
}

#pragma mark -
#pragma mark Life Time

    //inserted from dataBase
- (void)awakeFromFetch {
    [super awakeFromFetch];
    
}
    //create from MOC
- (void)awakeFromInsert {
    [super awakeFromInsert];
}

#pragma mark -
#pragma mark Accsessors 

- (NSURL *)imageUrl {
    return [NSURL URLWithString:self.imageURL];
}

- (NSString *)fullName {
    return [NSString stringWithFormat:@"%@ %@", self.firstName, self.lastName];
}

#pragma mark -
#pragma mark Private Methods

- (id)forwardingTargetForSelector:(SEL)aSelector {
    return self.userObservationTarget;
}

- (SEL)selectorForState:(NSUInteger)state {
    switch (state) {
        case ANSUserDidLoadIDD:
            return @selector(userDidLoadID:);
            
        case ANSUserDidLoadBasicc:
            return @selector(userDidLoadBasic:);
            
        case ANSUserDidLoadDetailss:
            return @selector(userDidLoadDetails:);
            
        default:
            return [self.userObservationTarget selectorForState:state];
    }
}

#pragma mark -
#pragma mark Public methods

- (void)fillWithRandom {
    self.idNumber = ANSRandomIntegerWithValues(10000, 99999);
    self.firstName = [NSString randomStringWithLength:5
                                             alphabet:[NSString alphanumericAlphabet]];
    
    self.firstName = [NSString randomStringWithLength:5
                                             alphabet:[NSString alphanumericAlphabet]];
}

+ (instancetype)objectWithID:(NSUInteger)ID {
    ANSUser *object = [self objectWithPredicate:[NSPredicate predicateWithFormat:@"idNumber = %ld", ID]];
    if (!object) {
        object = [self object];
        object.idNumber = ID;
    }
    
    return object;
}

@end
