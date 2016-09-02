//
//  ANSLoadimgModel.h
//  Objective-C UI Project
//
//  Created by Nikola Andriiev on 02.09.16.
//  Copyright © 2016 Andriiev.Mykola. All rights reserved.
//

#import "ANSObservableObject.h"

//return YES if loaded, otherwise NO;
typedef BOOL(^ANSLoadingBlock)(void);

@class ANSLoadingModel;

@protocol ANSLoadingModelObserver <NSObject>

@optional

- (void)loadingModelWillLoad:(ANSLoadingModel *)model;
- (void)loadingModelLoading:(ANSLoadingModel *)model;
- (void)loadingModelDidLoad:(ANSLoadingModel *)model;
- (void)loadingModelDidFailLoading:(ANSLoadingModel *)model;

@end

@interface ANSLoadingModel : ANSObservableObject

typedef NS_ENUM(NSUInteger, ANSLoadingState) {
    ANSLoadingModelUnloaded,
    ANSLoadingModelWillLoad,
    ANSLoadingModelLoading,
    ANSLoadingModelDidLoad,
    ANSLoadingModelDidFailLoading,
    
    ANSLoadingModelStatesCount
};

- (void)loadWithBlock:(ANSLoadingBlock)block;

@end
