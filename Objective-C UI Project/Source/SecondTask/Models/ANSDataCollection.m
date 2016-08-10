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
#import "ANSData.h"

typedef NS_ENUM(NSUInteger, ANSCollectionAction) {
    ANSCollectionAddData,
    ANSCollectionRemoveData,
    ANSCollectionMoveData
};

static NSString * const kANSArchiveKey              = @"kANSArchiveKey";
static NSString * const kANSCollectionKey           = @"kANSCollectionKey";

@interface ANSDataCollection ()
@property (nonatomic, retain) NSMutableArray *mutableDataCollection;
@property (nonatomic, retain) ANSBuffer *tempBuffer;

@end

@implementation ANSDataCollection

@synthesize state = _state;

@dynamic count;
@dynamic objects;

#pragma mark -
#pragma mark Initialization and deallocation

- (void)dealloc {
    NSLog(@"collection model deallocated");
}

- (instancetype)init {
    self = [super init];
    self.mutableDataCollection = [NSMutableArray new];
    
    return self;
}

#pragma mark -
#pragma mark Accsessors

- (void)setState:(NSUInteger)state withUserInfo:(id)userInfo {
    @synchronized(self) {
        _state = state;
            
        [self notifyOfStateChange:state withUserInfo:userInfo];
    }
}

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
            
            [self setState:ANSCollectionAddData withUserInfo:buffer];
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
            
            [self setState:ANSCollectionRemoveData withUserInfo:buffer];
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
            [self removeData:data];
            [self insertData:data atIndex:toIndex];
        }
    }
}

#pragma mark -
#pragma mark sorting ANSData by name

- (void)sortArray {
    [self.mutableDataCollection sortUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        if ([obj1 isKindOfClass:[ANSData class]] && [obj2 isKindOfClass:[ANSData class]]) {
             return [[obj1 string] compare:[obj2 string]];
        }
        
        return (NSComparisonResult)NSOrderedSame;
    }];
}

#pragma mark -
#pragma mark Save and loading (Public methods)

- (void)saveState {
    NSData *archive = [NSKeyedArchiver archivedDataWithRootObject:self];
    [[NSUserDefaults standardUserDefaults] setObject:archive forKey:kANSArchiveKey];
    NSLog(@"saveState");
}

+ (id)loadState {
    NSData *archive = [[NSUserDefaults standardUserDefaults] objectForKey:kANSArchiveKey];
    if (archive) {
        NSLog(@"loadState");
        return [NSKeyedUnarchiver unarchiveObjectWithData:archive];
    }
    
    return nil;
}

#pragma mark -
#pragma mark Reloaded methods

- (id)objectAtIndexedSubscript:(NSUInteger)idx {
    @synchronized(self) {
        return [self.mutableDataCollection objectAtIndex:idx];
    }
}

- (SEL)selectorForState:(NSUInteger)state {
    return @selector(collection:didUpdateData:);
}

#pragma mark -
#pragma mark NSFastEnumeration

- (NSUInteger)countByEnumeratingWithState:(NSFastEnumerationState *)state
                                  objects:(id __unsafe_unretained [])buffer
                                    count:(NSUInteger)len {
    
   return [self.mutableDataCollection countByEnumeratingWithState:state objects:buffer count:len];
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
#pragma mark NSCopying protocol

- (id)copyWithZone:(NSZone *)zone {
    id copy = [[self class] new];
    if (copy) {
        [copy setMutableDataCollection:[self.mutableDataCollection copyWithZone:zone]];
    }
    
    return copy;
}

@end
