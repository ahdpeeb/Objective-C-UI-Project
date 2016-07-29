//
//  ANSAlphabet.h
//  Objective-c course
//
//  Created by Nikola Andriiev on 12.06.16.
//  Copyright © 2016 Anfriiev.Mykola. All rights reserved.
//

#import <Foundation/Foundation.h>

FOUNDATION_EXPORT
NSRange ANSCreateAlphabetRange(unichar value1, unichar value2);

@interface ANSAlphabet : NSObject <NSFastEnumeration>
@property (nonatomic, assign) NSUInteger count;

+ (instancetype)alphabetWithRange:(NSRange)range;
+ (instancetype)alphabetWithStrings:(NSArray *)strings;
+ (instancetype)alphabetWithAlphabets:(NSArray *)alphabers;
+ (instancetype)alphabetWithCharacters:(NSString *)string;

- (instancetype)initWithRange:(NSRange)range;
- (instancetype)initWithAlphabets:(NSArray *)alphabets;
- (instancetype)initWithStrings:(NSArray *)strings;
- (instancetype)initWithSymbols:(NSString *)string;

// take string at index
- (NSString *)stringAtIndex:(NSUInteger)index;

- (NSString *)objectAtIndexedSubscript:(NSUInteger)index;

  // converts the alphabet in a row
- (NSString *)string;

@end
