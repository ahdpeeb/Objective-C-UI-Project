//
//  ANSDataCollection.m
//  Objective-C UI Project
//
//  Created by Nikola Andriiev on 24.07.16.
//  Copyright © 2016 Andriiev.Mykola. All rights reserved.
//

#import "ANSDataCollection.h"

@interface ANSDataCollection ()
@property (nonatomic, retain) NSMutableArray *mutableData;

@end

@implementation ANSDataCollection

@dynamic count;
@dynamic objects;

#pragma mark -
#pragma mark Initialization and deallocation

- (instancetype)init {
    self = [super init];
    self.mutableData = [NSMutableArray new];
    
    return self;
}

#pragma mark -
#pragma mark Accsessors

- (NSUInteger)count {
    return self.mutableData.count;
}

- (NSArray *)objects {
    return [self.mutableData copy];
}

#pragma mark -
#pragma mark Public methods; 
//Data / index from array
- (id)dataAtIndex:(NSUInteger)index {
    NSMutableArray *collection = self.mutableData;
    
    if (index >= collection.count) {
        return nil;
    }
    
    return [collection objectAtIndex:index];
}

- (NSUInteger)indexOfData:(id)data {
    if (data || [self.mutableData containsObject:data]) {
        return [self.mutableData indexOfObject:data];
    }
    
    return NSNotFound;
}

- (void)addData:(id)data {
    [self insertData:data atIndex:self.count];
}

- (void)removeData:(id)data {
    NSMutableArray *collection = self.mutableData;
    
    if ([collection containsObject:data]) {
        [collection removeObject:data];
        [self notifyObserversWithSelector:@selector(collectionDidRemovedData:)];
    }
}

- (void)insertData:(id)data atIndex:(NSUInteger)index {
    NSMutableArray *collection = self.mutableData;
    NSUInteger count = collection.count;
    
    if (!data || (index > count)) {
        return;
    }
    
    if (![collection containsObject:data]) {
        [collection insertObject:data atIndex:index];
        [self notifyObserversWithSelector:@selector(collectionDidAddedData:)];
    }
}

- (void)removeDataAtIndex:(NSUInteger)index {
    id data = [self dataAtIndex:index];
    [self removeData:data];
}

- (void)moveDataFromIndex:(NSUInteger)fromIndex toIndex:(NSUInteger)toIndex {
    NSMutableArray *collection = self.mutableData;
    NSUInteger count = collection.count;
    
    if ((fromIndex >= count) || (toIndex >= count)) {
        return;
    }
    
    if (fromIndex != toIndex) {
        [collection exchangeObjectAtIndex:fromIndex withObjectAtIndex:toIndex];
        [self notifyObserversWithSelector:@selector(collectionDidMovedData:)];
    }
}

- (void)addDataObjects:(NSArray*)objects {
    [self.mutableData addObjectsFromArray:objects];
    [self notifyObserversWithSelector:@selector(collectionDidAddedData:)];
}

#pragma mark -
#pragma mark Privat methods

- (id)objectAtIndexedSubscript:(NSUInteger)idx {
    return [self.mutableData objectAtIndex:idx];
}

@end
