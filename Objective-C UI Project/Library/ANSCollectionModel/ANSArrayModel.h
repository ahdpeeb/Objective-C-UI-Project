
//  Objective-C UI Project
//
//  Created by Nikola Andriiev on 24.07.16.
//  Copyright © 2016 Andriiev.Mykola. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "ANSObservableObject.h"

@class ANSArrayModel;
@class ANSChangeModel;

@protocol ANSCollectionObserver <NSObject>

@optional
- (void)       collection:(ANSArrayModel *)collection
    didChangeWithModel:(ANSChangeModel *)model;

@end

@interface ANSArrayModel : ANSObservableObject <
    NSCoding,
    NSCopying,
    NSFastEnumeration
>

@property (nonatomic, readonly) NSUInteger  count;
@property (nonatomic, readonly) NSArray     *objects;

- (id)objectAtIndex:(NSUInteger)index;
- (NSUInteger)indexOfObject:(id)object;
- (id)objectAtIndexedSubscript:(NSUInteger)idx;

- (void)addObject:(id)object;
- (void)removeObject:(id)object;

- (void)insertObject:(id)object atIndex:(NSUInteger)index;
- (void)removeObjectAtIndex:(NSUInteger)index;

- (void)addObjects:(NSArray*)objects;

- (void)moveObjectFromIndex:(NSUInteger)index toIndex:(NSUInteger)index; 
- (void)exchangeObjectAtIndex:(NSUInteger)indexOne
            withObjectAtIndex:(NSUInteger)indexTwo;

// this methods intended for save and load currect collection state;
- (void)saveState;
+ (id)loadState;

@end
