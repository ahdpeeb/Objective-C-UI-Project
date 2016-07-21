//
//  ANSRangeAlphabet.m
//  Objective-c course
//
//  Created by Nikola Andriiev on 12.06.16.
//  Copyright © 2016 Anfriiev.Mykola. All rights reserved.
//

#import "ANSRangeAlphabet.h"

#import "NSObject+ANSExtension.h"

@interface ANSRangeAlphabet ()
@property (nonatomic, assign) NSRange range;
@property (nonatomic, assign) NSUInteger countValue;
@property (nonatomic, assign) id *strings;

@end

@implementation ANSRangeAlphabet

#pragma mark -
#pragma mark Initialization and deallocation

- (void)dealloc {
    self.strings = nil;
    
    
    [super dealloc];
}

- (instancetype)initWithRange:(NSRange)range {
    self = [super init];
    if (self) {
        self.range = range;
        self.strings = malloc(sizeof(id *) * self.count);
    }
    
    return self;
    
}

#pragma mark -
#pragma mark Accessors

- (NSUInteger)count {
    return self.range.length;
}

#pragma mark -
#pragma mark Public

- (NSString *)stringAtIndex:(NSUInteger)index {
    return [NSString stringWithFormat:@"%c", (unichar)(self.range.location + index)];
}

- (NSUInteger)countByEnumeratingWithState:(NSFastEnumerationState *)state
                                  objects:(id [])buffer
                                    count:(NSUInteger)len
{
    NSUInteger countValue = self.countValue;
    state->mutationsPtr = (unsigned long *)self;
    countValue = self.count;
    if (state->state >= countValue) {
        return 0;
    }
    
    for (NSUInteger index = 0; index < countValue; index ++) {
        NSString *symbol = [self stringAtIndex:index];
        self.strings[index] = symbol;
    }
    
    state->itemsPtr = self.strings;
    state->state = countValue;
    
    return countValue;
}
    
@end
