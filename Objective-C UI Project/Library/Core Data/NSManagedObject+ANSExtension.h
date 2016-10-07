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
+ (instancetype)newObject;

// returns all objects from dataBase
+ (NSArray *)objectsFromBase;
+ (NSArray *)objectsFromBaseWithSortDescriptors:(NSArray<NSSortDescriptor *> *)sortDescriptors
                                      predicate:(NSPredicate *)predicate
                                     batchCount:(NSUInteger)count;
//save MO to dataBase
//MO must be inserted to sharedManager MOC and configureted before saving
- (BOOL)save;

//dalate MO from DB
- (BOOL)delate;

//coreDate defult set/get implementation for key
- (void)setCustomValue:(id)value forKey:(NSString *)key;
- (id)customValue:(id)value forKey:(NSString *)key;

- (void)setCustomValue:(id)value inMutableSetForKey:(NSString *)key;
- (void)removeCustomValue:(id)value inMutableSetForKey:(NSString *)key;

- (void)addCustomValues:(NSSet *)values inMutableSetForKey:(NSString *)key;
- (void)removeCustomValues:(NSSet *)values inMutableSetForKey:(NSString *)key;

@end
