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

- (void)model:(ANSArrayModel *)model didFilterWithUserInfo:(id)userInfo;
- (void)userModelDidLoad:(ANSArrayModel *)model;

@end

typedef NS_ENUM(NSUInteger, ANSUsersModelState) {
    ANSUsersModelInitWithObjectState = ANSStateCount,
    ANSUsersModelFilterdState,
    ANSUsersModelCountState
};

@interface ANSUsersModel : ANSArrayModel

- (NSArray *)descendingSortedUsers; 
- (ANSUsersModel *)sortedCollectionByString:(NSString *)filterStirng;
- (void)sortCollectionInBackgroundByString:(NSString *)filterStirng; 

@end
