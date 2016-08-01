//
//  ANSDataCollection.m
//  Objective-C UI Project
//
//  Created by Nikola Andriiev on 24.07.16.
//  Copyright © 2016 Andriiev.Mykola. All rights reserved.
//
#import <UIKit/UIKit.h>

#import "ANSDataCollection.h"

#import "ANSBuffer.h"

static NSString * const kANSArchiveKey              = @"kANSArchive";
static NSString * const kANSCollectionKey           = @"kANSCollectionKey";

@interface ANSDataCollection ()
@property (nonatomic, retain) NSMutableArray *mutableDataCollection;

@end

@implementation ANSDataCollection

@dynamic count;
@dynamic objects;

#pragma mark -
#pragma mark Initialization and deallocation

- (void)dealloc {
    NSLog(@"collection model deallocatin");
}

- (instancetype)init {
    self = [super init];
    self.mutableDataCollection = [NSMutableArray new];
    
    return self;
}

#pragma mark -
#pragma mark Accsessors

- (NSUInteger)count {
    @synchronized(self) {
        return self.mutableDataCollection.count;
    }
}

- (NSArray *)objects {
    @synchronized(self) {
        return [self.mutableDataCollection copy];
    }
}

#pragma mark -
#pragma mark Public methods; 
//Data / index from array
- (id)dataAtIndex:(NSUInteger)index {
    @synchronized(self) {
        return [self.mutableDataCollection objectAtIndex:index];
    }
}

- (NSUInteger)indexOfData:(id)data {
    @synchronized(self) {
        return [self.mutableDataCollection indexOfObject:data];
    }
}

- (void)addData:(id)data {
    @synchronized(self) {
        [self insertData:data atIndex:0];
    }
}

- (void)removeData:(id)data {
    @synchronized(self) {
        NSUInteger index = [self indexOfData:data];
        [self removeDataAtIndex:index];
    }
}

- (void)insertData:(id)data atIndex:(NSUInteger)index {
    @synchronized(self) {
        NSMutableArray *collection = self.mutableDataCollection;
        NSUInteger count = collection.count;
        
        if (!data || (index > count)) {
            return;
        }
        
        if (![collection containsObject:data]) {
            ANSBuffer *buffer = [ANSBuffer allocWithObject:data value:index];
            buffer.selector = @selector(insertRowsAtIndexPaths:withRowAnimation:);
            
            [collection insertObject:data atIndex:index];
            
            [self notifyObserversWithSelector:@selector(collection:didUpdateData:) object:buffer];
        }
    }
}

- (void)removeDataAtIndex:(NSUInteger)index {
    @synchronized(self) {
        id object = [self dataAtIndex:index];
        if (object) {
            ANSBuffer *buffer = [ANSBuffer allocWithObject:object value:index];
            buffer.selector = @selector(deleteRowsAtIndexPaths:withRowAnimation:);
            [self.mutableDataCollection removeObjectAtIndex:index];
            [self notifyObserversWithSelector:@selector(collection:didUpdateData:) object:buffer];
        }
    }
}

- (void)addDataObjects:(NSArray *)objects {
    @synchronized(self) {
        for (id object in objects) {
            [self insertData:object atIndex:self.count];
        }
    }
}

- (void)moveDataFromIndex:(NSUInteger)fromIndex toIndex:(NSUInteger)toIndex {
    @synchronized(self) {
        NSUInteger count = self.mutableDataCollection.count;
        
        if ((fromIndex >= count) || (toIndex >= count)) {
            return;
        }
        
        if (fromIndex != toIndex) {
            id data = [self dataAtIndex:fromIndex];
            [self removeDataAtIndex:fromIndex];
            [self insertData:data atIndex:toIndex];
        }
    }
}

#pragma mark -
#pragma mark Reloaded methods

- (id)objectAtIndexedSubscript:(NSUInteger)idx {
    @synchronized(self) {
        return [self.mutableDataCollection objectAtIndex:idx];
    }
}

#pragma mark -
#pragma mark NSCoding protocol

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:self.mutableDataCollection forKey:kANSCollectionKey];
}

- (nullable instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super init];
    if (self) {
        NSArray *archive = [aDecoder decodeObjectForKey:kANSCollectionKey];
        self.mutableDataCollection = [[NSMutableArray alloc] initWithArray:archive copyItems:YES];
    }
    
    return self;
}

#pragma mark -
#pragma mark Save and loading

+ (void)saveState {
    NSData *archive = [NSKeyedArchiver archivedDataWithRootObject:self];
    [[NSUserDefaults standardUserDefaults] setObject:archive forKey:kANSArchiveKey];
    NSLog(@"saveState");
}

+ (id)loadState {
    NSData *archive = [[NSUserDefaults standardUserDefaults] objectForKey:kANSArchiveKey];
    if (archive) {
       id object = [NSKeyedUnarchiver unarchiveObjectWithData:archive];
        NSLog(@"loadState");
        
        return object;
    }
    
    return nil;
}

- (id)copyWithZone:(NSZone *)zone {
    id copy = [[self class] new];
    if (copy) {
        [copy setMutableDataCollection:[self.mutableDataCollection copyWithZone:zone]];
    }
    
    return copy;
}

@end
