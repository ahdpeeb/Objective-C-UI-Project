//
//  ANSRangeAlphabet.h
//  Objective-c course
//
//  Created by Nikola Andriiev on 12.06.16.
//  Copyright © 2016 Anfriiev.Mykola. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "ANSAlphabet.h"

@interface ANSRangeAlphabet : ANSAlphabet
@property (nonatomic, readonly) NSRange range;

- (instancetype)initWithRange:(NSRange)range;

@end
