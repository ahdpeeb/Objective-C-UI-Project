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

@protocol ANSCollectionObserver <NSObject>

@optional
- (void)collection:(ANSDataCollection *)collection didAddData:(id)data;
- (void)collection:(ANSDataCollection *)collection didRemoveData:(id)data;
- (void)collection:(ANSDataCollection *)collection didMoveData:(id)data;
//test
- (void)collectionDidInit:(ANSDataCollection *)collection;

@end

//_____________________________________________________________
@interface ANSDataCollection : ANSObservableObject
@property (nonatomic, readonly) NSUInteger  count;
@property (nonatomic, readonly) NSArray     *objects;

- (id)dataAtIndex:(NSUInteger)index;
- (NSUInteger)indexOfData:(id)data;

- (void)addData:(id)data;
- (void)removeData:(id)data;

- (void)insertData:(id)data atIndex:(NSUInteger)index;
- (void)removeDataAtIndex:(NSUInteger)index;

- (void)moveDataFromIndex:(NSUInteger)fromIndex toIndex:(NSUInteger)toIndex;

- (void)addDataObjects:(NSArray*)objects;

// dot'n call this method directly
- (id)objectAtIndexedSubscript:(NSUInteger)idx; 

@end
