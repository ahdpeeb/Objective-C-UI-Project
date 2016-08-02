//
//  ANSBlockObservationController.h
//  Objective-C UI Project
//
//  Created by Nikola Andriiev on 01.08.16.
//  Copyright © 2016 Andriiev.Mykola. All rights reserved.
//

#import "ANSObservationController.h"

@interface ANSBlockObservationController : ANSObservationController

- (void)setBlock:(ANSStateChangeBlock)block forState:(NSUInteger)state;
- (void)remove:(ANSStateChangeBlock)block forState:(NSUInteger)state;
- (ANSStateChangeBlock)blockForState:(NSUInteger)state;
- (BOOL)containsBlockForState:(NSUInteger)state;

@end
