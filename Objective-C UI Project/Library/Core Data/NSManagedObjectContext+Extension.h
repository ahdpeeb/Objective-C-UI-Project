//
//  NSManagedObjectContext+Extension.h
//  Objective-C UI Project
//
//  Created by Nikola Andriiev on 05.10.16.
//  Copyright © 2016 Andriiev.Mykola. All rights reserved.
//

#import <CoreData/CoreData.h>

typedef void(^ANSConfiguretionBlock)(NSManagedObject *object);

@interface NSManagedObjectContext (Extension)

// This method insert new managedObject to context
// You objective-c class name mast match with entityName
- (NSManagedObject *)managedObjectWithClass:(NSString *)cls;

//managedObject should already be inserted to context.
//this method customizes your managedObject and save it to data base;
// if saved returned YES, otherwise NO
- (BOOL)    saveManagedObject:(NSManagedObject *)object
       withConfiguretionBlock:(ANSConfiguretionBlock)block;

//returns all managedObjects from dataBase with given class
- (NSArray *)objectsFromDataBaseWithCls:(NSString *)cls;

//returns managedObjects from dataBase, filteres by predicate conditions, sorted by sortDescriptors;
- (NSArray *)sortedObjectsWith:(Class)cls
               sortDescriptors:(NSArray<NSSortDescriptor *> *)sortDescriptors
                     predicate:(NSPredicate *)predicate;

//remove objects from data base
- (void)removeObjects:(NSArray <NSManagedObject *> *)objects;

@end
