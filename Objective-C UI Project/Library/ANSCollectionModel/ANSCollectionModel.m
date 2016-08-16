//
//  ANSCollectionModel
//  Objective-C UI Project
//
//  Created by Nikola Andriiev on 24.07.16.
//  Copyright © 2016 Andriiev.Mykola. All rights reserved.
//
#import <UIKit/UIKit.h>

#import "ANSCollectionModel.h"

#import "ANSChangeModel.h"
#import "NSMutableArray+ANSExtension.h"

static NSString * const kANSArchiveKey              = @"kANSArchiveKey";
static NSString * const kANSCollectionKey           = @"kANSCollectionKey";

@interface ANSCollectionModel ()
@property (nonatomic, retain) NSMutableArray *mutableObjects;

- (void)notifyOfChangeWithIndex:(NSUInteger)index state:(ANSChangeState)state;

- (void)notifyOfChangeWithIndex:(NSUInteger)indexOne
                         index2:(NSUInteger)indexTwo
                          state:(ANSChangeState)state;

@end

@implementation ANSCollectionModel

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
    self.mutableObjects = [NSMutableArray new];
    
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
        return self.mutableObjects.count;
    }
}

- (NSArray *)objects {
    @synchronized(self) {
        return [self.mutableObjects copy];
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
    ANSChangeModel *model = [ANSChangeModel twoIndexModel:index1 indexTwo:index2];
    model.state = state;
    [self notifyOfStateChange:0 withUserInfo:model];
}

#pragma mark -
#pragma mark Public methods; 

- (id)objectAtIndex:(NSUInteger)index {
    @synchronized(self) {
        return [self.mutableObjects objectAtIndex:index];
    }
}

- (NSUInteger)indexOfObject:(id)object {
    @synchronized(self) {
        return [self.mutableObjects indexOfObject:object];
    }
}

- (void)addObject:(id)object {
    @synchronized(self) {
        [self insertObject:object atIndex:0];
    }
}

- (void)removeObject:(id)object {
    @synchronized(self) {
        NSUInteger index = [self indexOfObject:object];
        [self removeObjectAtIndex:index];
    }
}

- (void)insertObject:(id)object atIndex:(NSUInteger)index {
    @synchronized(self) {
        NSMutableArray *collection = self.mutableObjects;
        NSUInteger count = collection.count;
        
        if (!object || (index > count)) {
            return;
        }
        
        if (![collection containsObject:object]) {
            [collection insertObject:object atIndex:index];
            [self notifyOfChangeWithIndex:index state:ANSStateAddObject];
        }
    }
}

- (void)removeObjectAtIndex:(NSUInteger)index {
    @synchronized(self) {
        id object = [self objectAtIndex:index];
        if (object) {
            [self.mutableObjects removeObjectAtIndex:index];
            [self notifyOfChangeWithIndex:index state:ANSStateRemoveObject];
        }
    }
}

- (void)addObjects:(NSArray *)objects {
    @synchronized(self) {
        for (id object in objects) {
            [self insertObject:object atIndex:self.count];
        }
    }
}

- (void)moveObjectFromIndex:(NSUInteger)fromIndex toIndex:(NSUInteger)toIndex {
    @synchronized(self) {
        [self.mutableObjects moveObjectFromIndex:fromIndex toIndex:toIndex]; 
        [self notifyOfChangeWithIndex:fromIndex index2:toIndex state:ANSStateMoveObject];
    }
}

- (void)exchangeObjectAtIndex:(NSUInteger)indexOne withObjectAtIndex:(NSUInteger)indexTwo {
    @synchronized(self) {
        [self.mutableObjects exchangeObjectAtIndex:indexOne withObjectAtIndex:indexTwo];
        [self notifyOfChangeWithIndex:indexOne index2:indexTwo state:ANSStateExchangeObject];
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
        return [self.mutableObjects objectAtIndex:idx];
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
    
   return [self.mutableObjects countByEnumeratingWithState:state objects:buffer count:len];
}

#pragma mark -
#pragma mark NSCoding protocol

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:self.mutableObjects forKey:kANSCollectionKey];
}

- (nullable instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super init];
    if (self) {
        NSArray *archive = [aDecoder decodeObjectForKey:kANSCollectionKey];
        self.mutableObjects = [[NSMutableArray alloc] initWithArray:archive copyItems:YES];
    }
    
    return self;
}

#pragma mark -
#pragma mark NSCopying protocol

- (id)copyWithZone:(NSZone *)zone {
    ANSCollectionModel *copy = [[self class] new];
    if (copy) {
        copy.mutableObjects = [self.mutableObjects copyWithZone:zone];
    }
    
    return copy;
}

@end
