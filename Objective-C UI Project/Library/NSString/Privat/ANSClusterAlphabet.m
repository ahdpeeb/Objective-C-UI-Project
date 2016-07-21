//
//  ANSClasterAlphabet.m
//  Objective-c course
//
//  Created by Nikola Andriiev on 12.06.16.
//  Copyright © 2016 Anfriiev.Mykola. All rights reserved.
//

#import "ANSClusterAlphabet.h"

@interface ANSClusterAlphabet ()

@property (nonatomic, retain) NSArray *alphabets;
@property (nonatomic, assign) NSUInteger symbolsCount;

- (NSUInteger)symbolsCount:(NSArray *)alphabets;

@end
@implementation ANSClusterAlphabet

#pragma mark -
#pragma mark Initialization and deallocation

- (instancetype)initWithAlphabets:(NSArray *)alphabets {
    self = [super init];
    if (self) {
        self.alphabets = alphabets;
        self.symbolsCount = [self symbolsCount:alphabets];
    }
    
    return self;
}

#pragma mark -
#pragma mark Accessors

- (NSUInteger)count {
   return self.symbolsCount;
}

#pragma mark -
#pragma mark Public

- (NSString *)stringAtIndex:(NSUInteger)index {
    if (index < self.symbolsCount) {
        NSUInteger iteratedIndex = index;
        for (ANSAlphabet *alphabet in self.alphabets) {
            if (iteratedIndex < [alphabet count]) {
                NSString *value = alphabet[iteratedIndex];
                return value;
            }
            
            iteratedIndex -= [alphabet count];
        }
    }
    
    return nil;
}

- (NSString *)string {
    NSMutableString *string = [NSMutableString stringWithCapacity:[self count]];
    for (NSString *symbols in self) {
        NSLog(@"%@", symbols);
        [string appendString:symbols];
    }
    
    return [[string copy] autorelease];
}

#pragma mark -
#pragma mark Private

- (NSUInteger)symbolsCount:(NSArray *)alphabets {
    NSUInteger count = 0;
    for (ANSAlphabet *alphabet in self.alphabets) {
        count += [alphabet count];
    }
    
    return count;
}

@end
