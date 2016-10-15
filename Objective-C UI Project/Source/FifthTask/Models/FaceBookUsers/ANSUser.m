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

@dynamic imageUrl;
@dynamic fullName;
@dynamic imageModel;

#pragma mark -
#pragma mark Class methods

+ (instancetype)objectWithID:(NSUInteger)ID {
    @synchronized (self) {
        ANSUser *object = [self objectWithPredicate:[NSPredicate predicateWithFormat:@"idNumber = %ld", ID]];
        if (!object) {
            object = [self object];
            object.idNumber = ID;
        }
        
        return object;
    }
}

#pragma mark -
#pragma mark Initialization and deallocation

- (NSManagedObject *)initWithEntity:(NSEntityDescription *)entity
     insertIntoManagedObjectContext:( NSManagedObjectContext *)context
{
    self = [super initWithEntity:entity insertIntoManagedObjectContext:context];
    self.userObservationTarget = [[ANSObservableObject alloc] initWithTarget:self];
    
    return self;
}

//    //teken from dataBase
//- (void)awakeFromFetch {
//    [super awakeFromFetch];
//    
//}
//    //create from MOC
//- (void)awakeFromInsert {
//    [super awakeFromInsert];
//    self.userObservationTarget = [[ANSObservableObject alloc] initWithTarget:self];
//}

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
    @synchronized (self) {
        NSLog(@"to %@ sent %@ ",self.userObservationTarget, NSStringFromSelector(aSelector));
        return self.userObservationTarget;
    }
}

- (BOOL)respondsToSelector:(SEL)aSelector {
    return [super respondsToSelector:aSelector] || [self.userObservationTarget respondsToSelector:aSelector];
}

- (SEL)selectorForState:(NSUInteger)state {
    switch (state) {
        case ANSUserDidLoadID:
            return @selector(userDidLoadID:);
            
        case ANSUserDidLoadFriends:
            return @selector(userDidLoadFriends:);
            
        case ANSUserDidLoadDetails:
            return @selector(userDidLoadDetails:);
            
        default:
            return [self.userObservationTarget selectorForState:state];
    }
}

@end
