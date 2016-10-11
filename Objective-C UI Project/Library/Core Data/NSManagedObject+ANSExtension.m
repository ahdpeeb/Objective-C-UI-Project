//
//  NSManagedObject+ANSExtension.m
//  Objective-C UI Project
//
//  Created by Nikola Andriiev on 04.10.16.
//  Copyright © 2016 Andriiev.Mykola. All rights reserved.

#import "NSManagedObject+ANSExtension.h"

#import "ANSCoreDataManager.h"

@interface NSManagedObject (ANSPrivate)

+ (NSManagedObjectContext *)context;
- (NSManagedObjectContext *)context;

@end

@implementation NSManagedObject (ANSPrivate)

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

+ (NSFetchRequest *)request {
    NSString *name = NSStringFromClass([self class]);
    return [NSFetchRequest fetchRequestWithEntityName:name];
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
    NSError *saveArror = nil;
    if (![[self context] save:&saveArror]) {
        NSLog(@"%@", [saveArror localizedDescription]);
        return NO;
    }
    
    return YES;
}

- (void)refresh {
    [[self context] refreshObject:self mergeChanges:YES];
}

- (BOOL)remove {
    ANSCoreDataManager *manager = [ANSCoreDataManager sharedManager];
    [manager.managedObjectContext deleteObject:self];
    
    return [[self context] save:nil];
}

@end
