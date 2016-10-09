//
//  ANSUser.h
//  Objective-C UI Project
//
//  Created by Nikola Andriiev on 07.10.16.
//  Copyright © 2016 Andriiev.Mykola. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

#import "ANSObservableObjectPtotocol.h"

#import "ANSImageModel.h"

@class ANSObservableObject;
@class ANSUser;

@protocol ANSUserObserver <NSObject>

@optional;
- (void)userDidLoadID:(ANSUser *)user;
- (void)userDidLoadBasic:(ANSUser *)user;
- (void)userDidLoadDetails:(ANSUser *)user;
- (void)userDidFailLoading:(ANSUser *)user;

@end

typedef NS_ENUM(NSUInteger, ANSUserState) {
    ANSUserUnloaded,
    ANSUserDidFailLoading,
    ANSUserDidLoadID,
    ANSUserDidLoadBasic,
    ANSUserDidLoadDetails,
    
    ANSUserStateCount,
};

@interface ANSUser : NSManagedObject <ANSObservableObjectPtotocol>
@property (nonatomic, readonly) ANSObservableObject *userObservationTarget;

@property (nonatomic, readonly) NSString      *fullName;
@property (nonatomic, readonly) NSURL         *imageUrl;
@property (nonatomic, readonly) ANSImageModel *imageModel;

+ (instancetype)objectWithID:(NSUInteger)ID;

- (void)fillWithRandom;

@end

#import "ANSUser+CoreDataProperties.h"
