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

@protocol ANSCollectionObserverSpecial <ANSArrayModelObserver>

@optional

- (void)modeldidFilter:(ANSUsersModel *)model;
- (void)userModelDidLoad:(ANSUsersModel *)model;

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
- (void)sortCollectionByfilterStirng:(NSString *)filterStirng;

- (void)loadWithCount:(NSUInteger)count; 

- (void)save;
- (void)load;

@end
