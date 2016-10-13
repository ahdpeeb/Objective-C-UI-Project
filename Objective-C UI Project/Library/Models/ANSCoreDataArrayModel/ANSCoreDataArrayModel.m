//
//  ANSWrapedFetchedController.m
//  Objective-C UI Project
//
//  Created by Nikola Andriiev on 11.10.16.
//  Copyright © 2016 Andriiev.Mykola. All rights reserved.
//

#import <UIKit/UITableView.h>

#import "ANSCoreDataArrayModel.h"

#import "ANSCoreDataManager.h"
#import "NSManagedObject+ANSExtension.h"
#import "NSManagedObjectContext+Extension.h"
#import "NSIndexPath+ANSExtension.h"

@interface ANSCoreDataArrayModel ()
@property (nonatomic, strong)   id <ANSObservableObject>   object;
@property (nonatomic, strong)   NSFetchedResultsController *resultsController;
@property (nonatomic, readonly) NSManagedObjectContext     *context;

- (void)initResultsController;

@end

@implementation ANSCoreDataArrayModel

@dynamic context;
@dynamic count;

#pragma mark -
#pragma mark Initializations and deallocations

- (instancetype)initWithModel:(id <ANSObservableObject>)model {
    self = [super init];
    self.object = model;
    [self initResultsController];
    
    return self;
}

#pragma mark -
#pragma mark Accsessors 

- (NSUInteger)count {
   return [self.resultsController.fetchedObjects count];
}

- (NSManagedObjectContext *)context {
    return [[ANSCoreDataManager sharedManager] managedObjectContext];
}

- (void)setResultsController:(NSFetchedResultsController *)resultsController {
    if (_resultsController != resultsController) {
        _resultsController = resultsController;
    }
        _resultsController.delegate = self;
        NSError *error = nil;
        if (![_resultsController performFetch:&error]) {
            NSLog(@"%@", [error localizedDescription]);
            abort();
        }
}

#pragma mark -
#pragma mark Private methods

- (void)initResultsController {
    NSFetchRequest *reques = [NSManagedObject fetchRequestWithSortDescriptors:[self sortDescriptors]
                                                            predicate:[self predicate]
                                                           batchCount:[self batchCount]];
    
    self.resultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:reques
                                                                 managedObjectContext:self.context
                                                                   sectionNameKeyPath:nil
                                                                            cacheName:@"Master"];
}

#pragma mark -
#pragma mark For subclass reloading

- (NSArray<NSSortDescriptor *> *)sortDescriptors {
    return nil;
}

- (NSPredicate *)predicate {
    return nil;
}

- (NSUInteger)batchCount {
    return 0;
}

#pragma mark -
#pragma mark Public reloaded methods

- (BOOL)containsObject:(NSManagedObject *)object {
    for (NSManagedObject *entiti in self.resultsController.fetchedObjects) {
        if ([entiti.objectID isEqual:object.objectID]) {
            return YES;
        }
    }
    
    return NO;
}

- (id)objectAtIndex:(NSUInteger)index {
   return [self.resultsController objectAtIndexPath:[NSIndexPath indexPathWithIndex:index]];
}

- (NSUInteger)indexOfObject:(id)object {
    NSIndexPath *path = [self.resultsController indexPathForObject:object];
    
    return path.row;
}
- (id)objectAtIndexedSubscript:(NSUInteger)idx {
    return [self objectAtIndex:idx];
}

- (void)addObject:(NSManagedObject *)object {
    [object save];
}

- (void)removeObject:(NSManagedObject *)object {
    [object remove];
}

- (void)insertObject:(id)object atIndex:(NSUInteger)index {
    return;
}

- (void)removeObjectAtIndex:(NSUInteger)index {
    id object = [self objectAtIndex:index];
    [object remove];
}

- (void)addObjectsInRange:(NSArray *)objects {
    for (id object in objects) {
        [object save];
    }
}

- (void)removeAllObjects {
    NSArray *objects = self.resultsController.fetchedObjects;
    for (id object in objects) {
        [object remove];
    }
}

- (void)moveObjectFromIndex:(NSUInteger)index toIndex:(NSUInteger)toIndex {
    return;
}

- (void)exchangeObjectAtIndex:(NSUInteger)indexOne
            withObjectAtIndex:(NSUInteger)index2 {
    return;
}

#pragma mark -
#pragma mark NSFetchedResultsControllerDelegate delegate

- (void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject
       atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type
      newIndexPath:(NSIndexPath *)newIndexPath
{
    switch (type) {
        case NSFetchedResultsChangeInsert: {
            [self notifyOfChangeWithIndex:indexPath.row userInfo:nil state:ANSStateAddObject];
        }
        
        case NSFetchedResultsChangeDelete: {
            [self notifyOfChangeWithIndex:indexPath.row userInfo:nil state:ANSStateRemoveObject];
        }
        
        case NSFetchedResultsChangeMove: {
            [self notifyOfChangeWithIndex:indexPath.row
                                   index2:newIndexPath.row
                                 userInfo:nil
                                    state:ANSStateMoveObject];
        }
                
        case NSFetchedResultsChangeUpdate: {
            [self notifyOfChangeWithIndex:indexPath.row userInfo:nil state:ANSStateUpdateObject];
        }
           
        default:
            break;
    }
}

@end
