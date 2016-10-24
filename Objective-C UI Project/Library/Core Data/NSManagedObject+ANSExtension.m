//
//  NSManagedObject+ANSExtension.m
//  Objective-C UI Project
//
//  Created by Nikola Andriiev on 04.10.16.
//  Copyright © 2016 Andriiev.Mykola. All rights reserved.

#import "NSManagedObject+ANSExtension.h"

#import "ANSCoreDataManager.h"

typedef void(^ANSOperationHandler)(NSMutableSet *primitiveSet, NSSet *changedObjects);

@interface NSManagedObject (ANSPrivate)

+ (NSManagedObjectContext *)context;
- (NSManagedObjectContext *)context;

@end

@implementation NSManagedObject (ANSPrivate)

#pragma mark -
#pragma mark Private methods

- (void)operationWithCustomValue:(id)value
              inMutableSetForKey:(NSString *)key
                 withSetMutation:(NSKeyValueSetMutationKind)setMutation
                     withHandler:(ANSOperationHandler)handler
{
    NSSet *changedObjects = [[NSSet alloc] initWithObjects:value, nil];
    [self willChangeValueForKey:key withSetMutation:setMutation usingObjects:changedObjects];
    NSMutableSet *primitiveSet = [self primitiveValueForKey:key];
    handler(primitiveSet, changedObjects);
    [self didChangeValueForKey:key withSetMutation:setMutation usingObjects:changedObjects];
}

- (void)operationWithCustomValues:(NSSet *)values
               inMutableSetForKey:(NSString *)key
                  withSetMutation:(NSKeyValueSetMutationKind)setMutation
                      withHandler:(ANSOperationHandler)handler
{
    [self willChangeValueForKey:key withSetMutation:setMutation usingObjects:values];
    NSMutableSet *primitiveSet = [self primitiveValueForKey:key];
    handler(primitiveSet, values);
    [self didChangeValueForKey:key withSetMutation:setMutation usingObjects:values];
}

#pragma mark -
#pragma mark Public Methods

+ (NSManagedObjectContext *)context {
    return [[ANSCoreDataManager sharedManager] managedObjectContext];
}

- (NSManagedObjectContext *)context {
   return [[self class] context];
}

@end

@implementation NSManagedObject (ANSExtension)

+ (instancetype)object {
    NSString *className = NSStringFromClass([self class]);
 
    return [NSEntityDescription insertNewObjectForEntityForName:className
                                         inManagedObjectContext:[self context]];
}

+ (NSFetchRequest *)fetchRequestWithSortDescriptors:(NSArray<NSSortDescriptor *> *)sortDescriptors
                                         predicate:(NSPredicate *)predicate
                                        batchCount:(NSUInteger)count
{
    NSFetchRequest *reques = [self fetchRequest];

    reques.sortDescriptors = sortDescriptors;
    reques.predicate = predicate;
    reques.fetchBatchSize = count;
    
    return reques;
}

+ (instancetype)objectWithPredicate:(NSPredicate *)predicate {
   return [[self objectsWithPredicate:predicate] firstObject];
}

+ (NSArray *)objects {
    return [self objectsWithSortDescriptors:nil predicate:nil batchCount:0];
}

+ (NSArray *)objectsWithPredicate:(NSPredicate *)predicate {
    return [self objectsWithSortDescriptors:nil predicate:predicate batchCount:0];
}

+ (NSArray *)objectsWithSortDescriptors:(NSArray<NSSortDescriptor *> *)sortDescriptors
                              predicate:(NSPredicate *)predicate
{
    return [self objectsWithSortDescriptors:sortDescriptors predicate:predicate batchCount:0];
}

+ (NSArray *)objectsWithSortDescriptors:(NSArray<NSSortDescriptor *> *)sortDescriptors
                              predicate:(NSPredicate *)predicate
                             batchCount:(NSUInteger)count
{
    NSFetchRequest *request = [self fetchRequestWithSortDescriptors:sortDescriptors
                                                          predicate:predicate
                                                         batchCount:count];
    
    NSError *executeError = nil;
    NSArray *objects = [[self context] executeFetchRequest:request error:&executeError];
    if (executeError) {
        NSLog(@"%@", [executeError localizedDescription]);
    }
    
    return objects;
}

- (BOOL)save {
    NSError *saveError = nil;
    if (![[self context] save:&saveError]) {
        NSLog(@"%@", [saveError localizedDescription]);
    }
    
    return !saveError;
}  

- (void)refresh {
    [[self context] refreshObject:self mergeChanges:YES];
}

- (void)dontSave {
    NSManagedObjectContext *context = self.context;
    [context deleteObject:self];
}

- (BOOL)remove {
    NSManagedObjectContext *context = self.context;
    [context deleteObject:self];
    
    return [[self context] save:nil];
}

- (void)setCustomValue:(id)value forKey:(NSString *)key {
    [self willChangeValueForKey:key];
    [self setPrimitiveValue:value forKey:key];
    [self didChangeValueForKey:key];
}

- (id)customvalueForKey:(NSString *)key {
    [self willChangeValueForKey:key];
    id result = [self primitiveValueForKey:key];
    [self didChangeValueForKey:key];
    
    return result;
}

- (void)addCustomValue:(id)value inMutableSetForKey:(NSString *)key {
    [self operationWithCustomValue:value inMutableSetForKey:key withSetMutation:NSKeyValueUnionSetMutation withHandler:^(NSMutableSet *primitiveSet, NSSet *changedObjects) {
        [primitiveSet unionSet:changedObjects];
    }];
}

- (void)removeCustomValue:(id)value inMutableSetForKey:(NSString *)key {
    [self operationWithCustomValue:value inMutableSetForKey:key withSetMutation:NSKeyValueMinusSetMutation withHandler:^(NSMutableSet *primitiveSet, NSSet *changedObjects) {
        [primitiveSet minusSet:changedObjects];
    }];
}

- (void)addCustomValues:(NSSet *)values inMutableSetForKey:(NSString *)key {
    [self operationWithCustomValues:values inMutableSetForKey:key withSetMutation:NSKeyValueUnionSetMutation withHandler:^(NSMutableSet *primitiveSet, NSSet *changedObjects) {
        [primitiveSet unionSet:changedObjects];
    }];
}

- (void)removeCustomValues:(NSSet *)values inMutableSetForKey:(NSString *)key {
    [self operationWithCustomValues:values inMutableSetForKey:key withSetMutation:NSKeyValueMinusSetMutation withHandler:^(NSMutableSet *primitiveSet, NSSet *changedObjects) {
        [primitiveSet minusSet:changedObjects];
    }];
}

@end
