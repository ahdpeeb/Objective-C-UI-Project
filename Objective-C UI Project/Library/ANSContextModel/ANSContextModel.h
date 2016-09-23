//
//  ANSContextModel.h
//  Objective-C UI Project
//
//  Created by Nikola Andriiev on 23.09.16.
//  Copyright © 2016 Andriiev.Mykola. All rights reserved.
//

#import "ANSObservableObject.h"

typedef NS_ENUM(NSUInteger, ANSContextState) {
    ANSContextExecuting,
    ANSContextDidFinishExecution,
    ANSContextDidFailedExecution,
    
    AANSContextStateCount
};

@class ANSContextModel;
@protocol ANSContextObserver <NSObject>
@optional;

- (void)contextExecuting:(ANSContextModel *)context;
- (void)contextDidFinishExecution:(ANSContextModel *)context;
- (void)contextDidFailedExecution:(ANSContextModel *)context;

@end

@interface ANSContextModel : ANSObservableObject
@property (nonatomic, readonly) id model;

- (instancetype)initWitModel:(id)model;

- (void)execute;

//You have to realod this method, to cancel processing your model;
- (void)cancel;

//need to be reloaded in child classes with notifications 
- (void)performProcessing;

@end
