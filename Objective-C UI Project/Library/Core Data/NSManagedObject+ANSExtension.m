//
//  NSManagedObject+ANSExtension.m
//  Objective-C UI Project
//
//  Created by Nikola Andriiev on 04.10.16.
//  Copyright © 2016 Andriiev.Mykola. All rights reserved.
//

#import "NSManagedObject+ANSExtension.h"

#import "ANSCoreDataManager.h"

@implementation NSManagedObject (ANSExtension)

+ (instancetype)newObject {
    ANSCoreDataManager *manager = [ANSCoreDataManager sharedManager];
    NSString *className = NSStringFromClass([self class]);
 
    return [NSEntityDescription insertNewObjectForEntityForName:className
                                         inManagedObjectContext:manager.managedObjectContext];

}

+ (NSArray *)objectsFromBase {
    return [self objectsFromBaseWithSortDescriptors:nil predicate:nil batchCount:0];
}

+ (NSArray *)objectsFromBaseWithSortDescriptors:(NSArray<NSSortDescriptor *> *)sortDescriptors
                                      predicate:(NSPredicate *)predicate
                                     batchCount:(NSUInteger)count
{
    NSManagedObjectContext *context = [[ANSCoreDataManager sharedManager] managedObjectContext];
    NSString *name = NSStringFromClass([self class]);
    NSFetchRequest *reques = [NSFetchRequest fetchRequestWithEntityName:name];
    
    reques.sortDescriptors = sortDescriptors;
    reques.predicate = predicate;
    reques.fetchBatchSize = count;
    
    NSError *executeError = nil;
    NSArray *objects = [context executeFetchRequest:reques error:&executeError];
    if (executeError) {
        NSLog(@"%@", [executeError localizedDescription]);
    }
    
    return objects;

}

- (BOOL)save {
    ANSCoreDataManager *manager = [ANSCoreDataManager sharedManager];
    NSError *saveArror = nil;
    if (![manager.managedObjectContext save:&saveArror]) {
        NSLog(@"%@", [saveArror localizedDescription]);
        return NO;
    }
    
    return YES;
}
- (BOOL)delate {
    ANSCoreDataManager *manager = [ANSCoreDataManager sharedManager];
    [manager.managedObjectContext deleteObject:self];
    
    return [manager.managedObjectContext save:nil];
}

#pragma mark -
#pragma mark Accsessors

- (void)setCustomValue:(id)value forKey:(NSString *)key {
    [self willChangeValueForKey:key];
    [self setPrimitiveValue:value forKey:key];
    [self didChangeValueForKey:key];
}

- (id)customValue:(id)value forKey:(NSString *)key {
    [self willAccessValueForKey:key];
    id resultValue = [self primitiveValueForKey:key];
    [self didAccessValueForKey:key];
    
    return resultValue;
}

- (void)setCustomValue:(id)value inMutableSetForKey:(NSString *)key {
    
}

- (void)removeCustomValue:(id)value inMutableSetForKey:(NSString *)key {

}

- (void)addCustomValues:(NSSet *)values inMutableSetForKey:(NSString *)key {

}

- (void)removeCustomValues:(NSSet *)values inMutableSetForKey:(NSString *)key {

}

@end
