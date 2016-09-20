//
//  ANSAlphabet.m
//  Objective-c course
//
//  Created by Nikola Andriiev on 12.06.16.
//  Copyright © 2016 Anfriiev.Mykola. All rights reserved.
//

#import "ANSAlphabet.h"


#import "NSString+ANSExtension.h"

NSRange ANSCreateAlphabetRange(unichar value1, unichar value2) {
    NSUInteger headValue = MIN(value1, value2);
    NSUInteger railValue = MAX(value1, value2);
    
    return NSMakeRange(headValue, railValue - headValue + 1);
}

@implementation ANSAlphabet

@dynamic count;

#pragma mark -
#pragma mark Class methods

+ (instancetype)alphabetWithRange:(NSRange)range {
    return [[[ANSRangeAlphabet alloc] initWithRange:range] autorelease];
}

+ (instancetype)alphabetWithStrings:(NSArray *)strings {
    return [[[ANSStringAlphabet alloc] initWithStrings:strings] autorelease];
}

+ (instancetype)alphabetWithCharacters:(NSString *)string {
    return [[[ANSStringAlphabet alloc] initWithStrings:[string symbols]] autorelease];
}

+ (instancetype)alphabetWithAlphabets:(NSArray *)alphabers {
    return [[[ANSClusterAlphabet alloc] initWithAlphabets:alphabers] autorelease];
}

#pragma mark -
#pragma mark Initialization and deallocation 

- (instancetype)initWithRange:(NSRange)range {
    [self release];
    
    ANSAlphabet *result = [[ANSRangeAlphabet alloc] initWithRange:range];
    
    return result;
}

- (instancetype)initWithStrings:(NSArray *)strings {
    [self release];
    
    ANSAlphabet *result = [[ANSStringAlphabet alloc] initWithStrings:strings];
    
    return result;
}

- (instancetype)initWithAlphabets:(NSArray *)alphabets {
    [self release];
    
    ANSAlphabet *result = [[ANSClusterAlphabet alloc] initWithAlphabets:alphabets];
    
    return result;
}

- (instancetype)initWithSymbols:(NSString *)string {
    [self release];
    
    ANSAlphabet *result = [self initWithStrings:[string symbols]];
    
    return result;
}

#pragma mark -
#pragma mark Accessors

- (NSUInteger)count {
    [self doesNotRecognizeSelector:_cmd];
    
    return 0;
}

#pragma mark -
#pragma mark Public methods

- (NSString *)stringAtIndex:(NSUInteger)index {
    [self doesNotRecognizeSelector:_cmd];
    
    return 0;
}

- (NSString *)objectAtIndexedSubscript:(NSUInteger)index {
    return [self stringAtIndex:index];
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
#pragma mark NSFastEnumeration

- (NSUInteger)countByEnumeratingWithState:(NSFastEnumerationState *)state
                                  objects:(id[])buffer
                                  count:(NSUInteger)len
{
    state->mutationsPtr = (unsigned long *)self;
    
    NSUInteger length = MIN(state->state + len, self.count);
    len = length - state->state;
    
    if (0 != len) {
        for (NSUInteger index = 0; index < len; index ++) {
            buffer[index] = self[index + state->state];
        }
    }
    
    state->itemsPtr = buffer;
    
    state->state += len;
    
    return len;
}

@end
