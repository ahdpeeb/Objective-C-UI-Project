//
//  ANSBlockObservationController.h
//  Objective-C UI Project
//
//  Created by Nikola Andriiev on 01.08.16.
//  Copyright © 2016 Andriiev.Mykola. All rights reserved.
//

#import "ANSObservationController.h"

typedef void(^ANSStateChangeBlock)(id observer, ANSObservableObject *observableObject, id userInfo);

@interface ANSBlockObservationController : ANSObservationController

- (void)setBlock:(ANSStateChangeBlock)block forState:(NSUInteger)state;
- (void)removeBlock:(ANSStateChangeBlock)block forState:(NSUInteger)state;

- (BOOL)containsBlockForState:(NSUInteger)state;
- (ANSStateChangeBlock)blockForState:(NSUInteger)state;

#pragma mark -
#pragma mark Addtional

- (ANSStateChangeBlock)objectAtIndexedSubscript:(NSUInteger)index;
- (void)setObject:(ANSStateChangeBlock)object atIndexedSubscript:(NSUInteger)index;

@end
