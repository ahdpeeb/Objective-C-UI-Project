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

@dynamic imageModel;

#pragma mark -
#pragma mark Life Time

    //inserted from dataBase
- (void)awakeFromFetch {
    [super awakeFromFetch];
    
}
    //create from MOC
- (void)awakeFromInsert {
    [super awakeFromInsert];
    self.userObservationTarget = [[ANSObservableObject alloc] initWithTarget:self];
}

#pragma mark -
#pragma mark Accsessors 

- (NSURL *)imageUrl {
    return [NSURL URLWithString:self.imageURL];
}

- (NSString *)fullName {
    return [NSString stringWithFormat:@"%@ %@", self.firstName, self.lastName];
}

- (ANSImageModel *)imageModel {
    return [ANSImageModel imageFromURL:self.imageUrl];
}

#pragma mark -
#pragma mark Private Methods

- (id)forwardingTargetForSelector:(SEL)aSelector {
    return self.userObservationTarget;
}

- (SEL)selectorForState:(NSUInteger)state {
    switch (state) {
        case ANSUserDidLoadID:
            return @selector(userDidLoadID:);
            
        case ANSUserDidLoadBasic:
            return @selector(userDidLoadBasic:);
            
        case ANSUserDidLoadDetails:
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
