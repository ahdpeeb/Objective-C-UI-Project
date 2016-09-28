//
//  NSString+ANSExtension.h
//  Objective-c course
//
//  Created by Nikola Andriiev on 09.06.16.
//  Copyright © 2016 Anfriiev.Mykola. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "ANSJSONRepresentation.h"

@interface NSString (ANSExtension) <ANSJSONRepresentation>

+ (instancetype)randomStringWithLength:(NSUInteger)length
                              alphabet:(NSString *)alphabet;

    // generate unicode symbols alphabet in range between firs ans last symbols;
+ (instancetype)alphabetWithUnicodeFirstSymbol:(unichar)firstSymbol
                                    lastSymbol:(unichar)lastSymbol;

+ (instancetype)alphanumericAlphabet;
+ (instancetype)numericAlphabet;
+ (instancetype)lowercaseLetterAlphabet;
+ (instancetype)capitalizedLetterAlphabet;
+ (instancetype)letterAlphabet;

- (NSArray *)symbols;

@end
