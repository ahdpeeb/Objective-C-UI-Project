//
//  ANSBuffer.m
//  Objective-C UI Project
//
//  Created by Nikola Andriiev on 28.07.16.
//  Copyright © 2016 Andriiev.Mykola. All rights reserved.
//

#import "ANSBuffer.h"

@implementation ANSBuffer

#pragma mark -
#pragma mark Initialization and deallocations 

+ (instancetype)allocWithObject:(id)object
                         value:(NSUInteger)value {
    
    return [[self alloc] initWithObject:object value:value];
}

- (instancetype)initWithObject:(id)object
                         value:(NSUInteger)value
{
    self = [super init];
    if (self) {
        self.object = object;
        self.value = value;
    }
    
    return self;
}

@end
