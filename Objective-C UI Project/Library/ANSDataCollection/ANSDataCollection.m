//
//  ANSDataCollection.m
//  Objective-C UI Project
//
//  Created by Nikola Andriiev on 24.07.16.
//  Copyright © 2016 Andriiev.Mykola. All rights reserved.
//
#import <UIKit/UIKit.h>

#import "ANSDataCollection.h"

#import "ANSDataInfo.h"
#import "ANSChangeModel.h"

static NSString * const kANSArchiveKey              = @"kANSArchiveKey";
static NSString * const kANSCollectionKey           = @"kANSCollectionKey";

@interface ANSDataCollection ()
@property (nonatomic, retain) NSMutableArray *mutableDataCollection;
@property (nonatomic, retain) ANSDataInfo *tempBuffer;

- (void)notifyOfChangeWithIndex:(NSUInteger)index state:(ANSChangeState)state;

- (void)notifyOfChangeWithIndex:(NSUInteger)index1
                         index2:(NSUInteger)index2
                          state:(ANSChangeState)state;

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
#pragma mark Private methods;

- (void)notifyOfChangeWithIndex:(NSUInteger)index state:(ANSChangeState)state {
    ANSChangeModel *model = [ANSChangeModel oneIndexModel:index];
    model.state = state;
    [self notifyOfStateChange:0 withUserInfo:model];
}

- (void)notifyOfChangeWithIndex:(NSUInteger)index1
                         index2:(NSUInteger)index2
                          state:(ANSChangeState)state
{
    ANSChangeModel *model = [ANSChangeModel twoIndexModel:index1 index2:index2];
    model.state = state;
    [self notifyOfStateChange:0 withUserInfo:model];
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
            [collection insertObject:data atIndex:index];
            
            [self notifyOfChangeWithIndex:index state:ANSStateAddData];
        }
    }
}

- (void)removeDataAtIndex:(NSUInteger)index {
    @synchronized(self) {
        id object = [self dataAtIndex:index];
        if (object) {
            [self.mutableDataCollection removeObjectAtIndex:index];
            
            [self notifyOfChangeWithIndex:index state:ANSStateRemoveData];
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
            
            [self notifyOfChangeWithIndex:fromIndex index2:toIndex state:ANSStateMoveData];
        }
    }
}

- (void)exchangeDataAtIndex:(NSUInteger)index1 withDataAtIndex:(NSUInteger)index2 {
    @synchronized(self) {
        [self.mutableDataCollection exchangeObjectAtIndex:index1 withObjectAtIndex:index2];
        
        [self notifyOfChangeWithIndex:index1 index2:index2 state:ANSStateExchangeData];
    }
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
    return @selector(collection:didChangeWithModel:);
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
