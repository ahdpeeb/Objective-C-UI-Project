//
//  ANSWrapedFetchedController.h
//  Objective-C UI Project
//
//  Created by Nikola Andriiev on 11.10.16.
//  Copyright © 2016 Andriiev.Mykola. All rights reserved.
//

#import <CoreData/CoreData.h>

#import "ANSArrayModel.h"
#import "ANSObservableObjectPtotocol.h"

@class ANSWrapedFetchedController;

@protocol ANSWrapedFetchedControllerObserver <NSObject>

- (void)wrapedFetchedController:(ANSWrapedFetchedController *)controller
                didUpdateObject:(id <ANSObservableObject>)object;

@end

typedef NS_ENUM(NSUInteger, ANSWrapedFetchedControllerState) {
    ANSWrapedFetchedControllerStateUpdate = ANSArrayModelStatesCount,
    
    ANSWrapedFetchedControllerStateCount
};

@interface ANSWrapedFetchedController : ANSArrayModel <NSFetchedResultsControllerDelegate>

//need to be reloaded
- (NSString *)sectionNameKeyPath;
- (NSArray<NSSortDescriptor *> *)sortDescriptors;

@end
