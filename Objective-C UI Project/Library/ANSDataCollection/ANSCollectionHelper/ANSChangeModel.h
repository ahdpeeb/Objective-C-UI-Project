//
//  ANSCollectionHelper.h
//  Objective-C UI Project
//
//  Created by Nikola Andriiev on 12.08.16.
//  Copyright © 2016 Andriiev.Mykola. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, ANSChangeState) {
    ANSStateAddData,
    ANSStateRemoveData,
    ANSStateMoveData,
    ANSStateExchangeData
};

@interface ANSChangeModel : NSObject
@property (nonatomic, assign) ANSChangeState state;

+ (instancetype)oneIndexModel:(NSUInteger)index; 
+ (instancetype)twoIndexModel:(NSUInteger)index index2:(NSUInteger)index2; 

- (NSUInteger)index;
- (NSUInteger)index2;

@end
