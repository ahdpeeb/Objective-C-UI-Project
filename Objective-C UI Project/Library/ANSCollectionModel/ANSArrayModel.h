
//  Objective-C UI Project
//
//  Created by Nikola Andriiev on 24.07.16.
//  Copyright © 2016 Andriiev.Mykola. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "ANSObservableObject.h"
#import "NSArray+ANSExtension.h"

@class ANSArrayModel;
@class ANSChangeModel;

@protocol ANSArrayModelObserver <NSObject>

@optional

- (void)    arrayModel:(ANSArrayModel *)arrayModel
    didChangeWithModel:(ANSChangeModel *)model;

@end

typedef NS_ENUM(NSUInteger, ANSArrayModelState) {
    ANSDefaultState,
    ANSStateCount
};

@interface ANSArrayModel : ANSObservableObject <
    NSCoding,
    NSCopying,
    NSFastEnumeration
>

@property (nonatomic, readonly)                     NSUInteger  count;
@property (nonatomic, readonly)                     NSArray     *objects;

- (id)objectAtIndex:(NSUInteger)index;
- (NSUInteger)indexOfObject:(id)object;
- (id)objectAtIndexedSubscript:(NSUInteger)idx;

- (void)addObject:(id)object;
- (void)removeObject:(id)object;

- (void)insertObject:(id)object atIndex:(NSUInteger)index;
- (void)removeObjectAtIndex:(NSUInteger)index;

- (void)addObjectsInRange:(NSArray*)objects;
- (void)removeAllObjects;

- (void)moveObjectFromIndex:(NSUInteger)index toIndex:(NSUInteger)index;
- (void)exchangeObjectAtIndex:(NSUInteger)indexOne
            withObjectAtIndex:(NSUInteger)index2;

@end
