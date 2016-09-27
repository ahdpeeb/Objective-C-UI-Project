//
//  NSString+ANSExtension.h
//  Objective-c course
//
//  Created by Nikola Andriiev on 09.06.16.
//  Copyright © 2016 Anfriiev.Mykola. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "ANSJSONRepresentationProtocol.h"

@interface NSString (ANSExtension) <ANSJSONRepresentationProtocol>

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

- (instancetype)JSONRepresentation;

@end
