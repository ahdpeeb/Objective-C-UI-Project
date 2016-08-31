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
@class ANSNameFilterModel;
@class ANSViewControllerTables;

@protocol ANSUsersModelObserver <ANSArrayModelObserver>

@optional

//- (void)usersModelDidFilter:(ANSUsersModel *)model;
- (void)usersModelDidLoad:(ANSUsersModel *)model;

@end

typedef NS_ENUM(NSUInteger, ANSUserLoadingState) {
    ANSUsersModelUnloaded = ANSStateCount,
    ANSUsersModelDidLoad,
    ANSUsersModelLoading,
    ANSUsersModelDidFailLoading,
    
    ANSUsersModelCountState
};

@interface ANSUsersModel : ANSArrayModel
@property (nonatomic, weak) ANSViewControllerTables *viewControllerObserver;

- (NSArray *)descendingSortedUsers;

- (void)save;
- (void)load;

// the last link 
- (void)sortCollectionByfilterStrirng:(NSString *)filterStrirng;

@end
