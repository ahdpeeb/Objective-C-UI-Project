//
//  NSManagedObject+ANSExtension.h
//  Objective-C UI Project
//
//  Created by Nikola Andriiev on 04.10.16.
//  Copyright © 2016 Andriiev.Mykola. All rights reserved.
//

#import <CoreData/CoreData.h>

// MO  - managedObject
// MOC - managedObjectContext;

@interface NSManagedObject (ANSExtension)

// This method insert new managedObject to sharedManager MOC
// You objective-c class name mast match with entityName
+ (instancetype)object;

//Returns first objects which suitable for predicae conditions
+ (instancetype)objectWithPredicate:(NSPredicate *)predicate;

+ (NSFetchRequest *)fetchReques;

+ (NSFetchRequest *)fetchRequesWithSortDescriptors:(NSArray<NSSortDescriptor *> *)sortDescriptors
                                         predicate:(NSPredicate *)predicate
                                        batchCount:(NSUInteger)count;

// returns all objects from dataBase
+ (NSArray *)objects;

+ (NSArray *)objectsWithPredicate:(NSPredicate *)predicate;

+ (NSArray *)objectsWithSortDescriptors:(NSArray<NSSortDescriptor *> *)sortDescriptors
                              predicate:(NSPredicate *)predicate;

+ (NSArray *)objectsWithSortDescriptors:(NSArray<NSSortDescriptor *> *)sortDescriptors
                              predicate:(NSPredicate *)predicate
                             batchCount:(NSUInteger)count;

//save MO to dataBase
//MO must be inserted to sharedManager MOC and configureted before saving
- (BOOL)save;

//refresh objects and merge changes
- (void)refresh;

//remove MO from DB
- (BOOL)remove;

@end
