//
//  ANSDataCollection.h
//  Objective-C UI Project
//
//  Created by Nikola Andriiev on 24.07.16.
//  Copyright © 2016 Andriiev.Mykola. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "ANSObservableObject.h"

@class ANSDataCollection;
@class ANSCollectionHelper;

@protocol ANSCollectionObserver <NSObject>

@optional
- (void)       collection:(ANSDataCollection *)collection
    didChangeWithHelper:(ANSCollectionHelper *)helper;

@end

typedef NS_ENUM(NSUInteger, ANSCollectionAction) {
    ANSCollectionAddData,
    ANSCollectionRemoveData,
    ANSCollectionMoveData
};

@interface ANSDataCollection : ANSObservableObject <
    NSCoding,
    NSCopying,
    NSFastEnumeration
>

@property (nonatomic, readonly) NSUInteger  count;
@property (nonatomic, readonly) NSArray     *objects;

- (id)dataAtIndex:(NSUInteger)index;
- (NSUInteger)indexOfData:(id)data;
- (id)objectAtIndexedSubscript:(NSUInteger)idx;

- (void)addData:(id)data;
- (void)removeData:(id)data;

- (void)insertData:(id)data atIndex:(NSUInteger)index;
- (void)removeDataAtIndex:(NSUInteger)index;

- (void)addDataObjects:(NSArray*)objects;

- (void)moveDataFromIndex:(NSUInteger)fromIndex toIndex:(NSUInteger)toIndex;

// this methods intended for save and load currect state of data collection;
- (void)saveState;
+ (id)loadState;

@end
