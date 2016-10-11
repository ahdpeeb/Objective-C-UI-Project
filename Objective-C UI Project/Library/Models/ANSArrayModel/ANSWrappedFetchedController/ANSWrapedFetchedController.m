//
//  ANSWrapedFetchedController.m
//  Objective-C UI Project
//
//  Created by Nikola Andriiev on 11.10.16.
//  Copyright © 2016 Andriiev.Mykola. All rights reserved.
//

#import "ANSWrapedFetchedController.h"

#import "ANSCoreDataManager.h"
#import "NSManagedObject+ANSExtension.h"
#import "NSManagedObjectContext+Extension.h"

@interface ANSWrapedFetchedController ()
@property (nonatomic, strong) NSFetchedResultsController *resultsController;
@property (nonatomic, readonly) NSManagedObjectContext   *context;

- (void)initResultsController;

@end

@implementation ANSWrapedFetchedController

@dynamic context;

#pragma mark -
#pragma mark Initializations and deallocations

- (instancetype)init {
    self = [super init];
    [self initResultsController];
    
    return self;
}

#pragma mark -
#pragma mark Accsessors 

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
    NSPredicate *predicate = nil;
    
    //all objects im dabase, which in self.objects
    predicate = [NSPredicate predicateWithFormat:@"friends contains %@", self.objects];
    NSFetchRequest *reques = [NSManagedObject fetchRequestWithSortDescriptors:[self sortDescriptors]
                                                            predicate:predicate
                                                           batchCount:0];
    
    self.resultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:reques
                                                                 managedObjectContext:self.context
                                                                   sectionNameKeyPath:nil
                                                                            cacheName:nil];
}

- (SEL)selectorForState:(NSUInteger)state {
    switch (state) {
        case ANSArrayModelDidChange:
            return @selector(arrayModel:didChangeWithModel:);
            
        default:
            return [super selectorForState:state];
    }
}

#pragma mark -
#pragma mark For subclass reloading

- (NSString *)sectionNameKeyPath {
    [self doesNotRecognizeSelector:_cmd];
    
    return nil;
}

- (NSArray<NSSortDescriptor *> *)sortDescriptors {
    [self doesNotRecognizeSelector:_cmd];
    
    return nil;
}

#pragma mark -
#pragma mark NSFetchedResultsControllerDelegate delegate

- (void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject
       atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type
      newIndexPath:(NSIndexPath *)newIndexPath
{
    switch (type) {
        case NSFetchedResultsChangeUpdate: {
            id <ANSObservableObject> object = [self.resultsController objectAtIndexPath:indexPath];
            [self notifyOfStateChange:ANSWrapedFetchedControllerStateUpdate withUserInfo:object];
            break;
        }
           
        default:
            break;
    }
}

@end
