//
//  ANSNameFilterModel.h
//  Objective-C UI Project
//
//  Created by Nikola Andriiev on 30.08.16.
//  Copyright © 2016 Andriiev.Mykola. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "ANSArrayModel.h"
#import "ANSUsersModel.h"

@class ANSNameFilterModel;

@protocol ANSNameFilterModelProtocol <ANSUsersModelObserver>

- (void)nameFilterModelDidFilter:(ANSNameFilterModel *)model;

@end

typedef NS_ENUM(NSUInteger, ANSNameFilterModelState) {
    ANSNameFilterModelDidFilter = ANSUsersModelCountState,
    
    ANSNameFilterModelCount
};

@interface ANSNameFilterModel : ANSArrayModel <ANSUsersModelObserver>
@property (nonatomic, readonly) id observableObject;

- (instancetype)initWithObservableModel:(ANSUsersModel *)model;

- (void)filterModelByfilterStrirng:(NSString *)filterStrirng;

@end
