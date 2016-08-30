//
//  ANSDataCollection.h
//  Objective-C UI Project
//
//  Created by Nikola Andriiev on 24.07.16.
//  Copyright © 2016 Andriiev.Mykola. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "ANSArrayModel.h"

@class ANSUsersModel;

@protocol ANSUsersModelObserver <ANSArrayModelObserver>

@optional

- (void)usersModelDidFilter:(ANSUsersModel *)model;
- (void)usersModelDidLoad:(ANSUsersModel *)model;

@end

typedef NS_ENUM(NSUInteger, ANSUsersModelState) {
    ANSUsersModelDidfilter = ANSStateCount,
    ANSUsersModelCountState
};

typedef NS_ENUM(NSUInteger, ANSUserLoadingState) {
    ANSUsersModelUnloaded = ANSUsersModelCountState,
    ANSUsersModelDidLoad,
    ANSUsersModelLoading,
    ANSUsersModelDidFailLoading
};

@interface ANSUsersModel : ANSArrayModel

- (NSArray *)descendingSortedUsers; 
- (void)sortCollectionByfilterStrirng:(NSString *)filterStrirng;

- (void)save;
- (void)load;

@end
