
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

@protocol ANSCollectionObserver <NSObject>

@optional

- (void)    collection:(ANSArrayModel *)collection
    didChangeWithModel:(ANSChangeModel *)model;

@end

typedef NS_ENUM(NSUInteger, ANSState) {
    ANSDefaultState,
    ANSStateCount
};

@interface ANSArrayModel : ANSObservableObject <
    NSCoding,
    NSCopying,
    NSFastEnumeration
>

@property (nonatomic, readonly)                     NSUInteger  count;
@property (nonatomic, readonly, getter=isLoaded)    BOOL        loaded;
@property (nonatomic, readonly)                     NSArray     *objects;

- (void)setState:(NSUInteger)state withUserInfo:(id)userInfo; 

- (id)objectAtIndex:(NSUInteger)index;
- (NSUInteger)indexOfObject:(id)object;
- (id)objectAtIndexedSubscript:(NSUInteger)idx;

//notify with ANSDefaultState state
- (void)addObject:(id)object;

//notify with ANSDefaultState state
- (void)removeObject:(id)object;

//notify with ANSDefaultState state
- (void)insertObject:(id)object atIndex:(NSUInteger)index;

//notify with ANSDefaultState state
- (void)removeObjectAtIndex:(NSUInteger)index;

- (void)addObjects:(NSArray*)objects;

//notify with ANSDefaultState state
- (void)moveObjectFromIndex:(NSUInteger)index toIndex:(NSUInteger)index;

//notify with ANSDefaultState state
- (void)exchangeObjectAtIndex:(NSUInteger)indexOne
            withObjectAtIndex:(NSUInteger)indexTwo;

@end
