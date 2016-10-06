//
//  NSManagedObjectContext+Extension.m
//  Objective-C UI Project
//
//  Created by Nikola Andriiev on 05.10.16.
//  Copyright © 2016 Andriiev.Mykola. All rights reserved.
//

#import "NSManagedObjectContext+Extension.h"

#import "ANSMacros.h"

@implementation NSManagedObjectContext (Extension)

- (NSManagedObject *)managedObjectWithClass:(Class)cls {
    return [NSEntityDescription insertNewObjectForEntityForName:NSStringFromClass(cls)
                                         inManagedObjectContext:self];
}

- (BOOL)    saveManagedObject:(NSManagedObject *)object
       withConfiguretionBlock:(ANSConfiguretionBlock)block
{
    ANSPerformBlockWithArguments(block, object); 
    NSError *saveArror = nil;
    if (![self save:&saveArror]) {
        NSLog(@"%@", [saveArror localizedDescription]);
        return NO;
    }
    
    return YES;  
}

- (NSArray *)objectsFromDataBaseWith:(Class)cls {
    NSString *name = NSStringFromClass(cls);
    NSFetchRequest *reques = [NSFetchRequest fetchRequestWithEntityName:name];
    NSError *executeError = nil;
    NSArray *objects = [self executeFetchRequest:reques error:&executeError];
    if (executeError) {
        NSLog(@"%@", [executeError localizedDescription]);
    }
    
    return objects;
}

- (NSArray *)sortedObjectsWith:(Class)cls
               sortDescriptors:(NSArray<NSSortDescriptor *> *)sortDescriptors
                     predicate:(NSPredicate *)predicate
{
    NSEntityDescription *description = nil;
    description = [NSEntityDescription entityForName:NSStringFromClass(cls)
                              inManagedObjectContext:self];
    NSFetchRequest *reques = [NSFetchRequest new];
    reques.entity = description;
    reques.sortDescriptors = sortDescriptors;
    reques.predicate = predicate;
    
    NSError *executeError = nil;
    NSArray *objects = [self executeFetchRequest:reques error:&executeError];
    if (executeError) {
        NSLog(@"%@", [executeError localizedDescription]);
    }
    
    return objects;
}

- (void)removeObjects:(NSArray <NSManagedObject *> *)objects {
    for (NSManagedObject *object in objects) {
        [self deleteObject:object];
    }
    
    [self save:nil];
}

@end
