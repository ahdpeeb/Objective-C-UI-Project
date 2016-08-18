//
//  ANSDataCollection.h
//  Objective-C UI Project
//
//  Created by Nikola Andriiev on 24.07.16.
//  Copyright © 2016 Andriiev.Mykola. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "ANSArrayModel.h"

@protocol ANSCollectionObserverSpecial <ANSCollectionObserver>

@optional

- (void)collection:(ANSArrayModel *)collection didFilterWithUserInfo:(id)userInfo;
- (void)filledModelDidInit:(ANSArrayModel *)model;

@end

//you should not touch defauld state
typedef NS_ENUM(NSUInteger, ANSState) {
    ANSDefaultState,
    ANSFilteredState,
    ANSInitedWithObjectState,
};

@interface ANSUsersCollection : ANSArrayModel

- (NSArray *)descendingSortedUsers; 
- (ANSUsersCollection *)sortedCollectionByString:(NSString *)filterStirng;
- (void)sortCollectionInBackgroundByString:(NSString *)filterStirng; 

@end
