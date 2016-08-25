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

@protocol ANSCollectionObserverSpecial <ANSCollectionObserver>

@optional

- (void)model:(ANSUsersModel *)model didFilterWithUserInfo:(id)userInfo;
- (void)userModelDidLoad:(ANSUsersModel *)model;

@end

typedef NS_ENUM(NSUInteger, ANSUsersModelState) {
    ANSUsersModelDidLoad = ANSStateCount,
    ANSUsersModelDidfilter,
    ANSUsersModelCountState
};

@interface ANSUsersModel : ANSArrayModel

- (NSArray *)descendingSortedUsers; 
- (void)sortCollectionByfilterStirng:(NSString *)filterStirng;

- (void)loadWithCount:(NSUInteger)count; 

- (void)save;
- (id)load;

@end
