//
//  ANSBuffer.h
//  Objective-C UI Project
//
//  Created by Nikola Andriiev on 28.07.16.
//  Copyright © 2016 Andriiev.Mykola. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ANSBuffer : NSObject
@property (nonatomic, retain) id object;
@property (nonatomic, assign) NSUInteger value;
@property (nonatomic, assign) SEL selector;

+ (instancetype)allocWithObject:(id)object
                          value:(NSUInteger)value; 

- (instancetype)initWithObject:(id)object
                         value:(NSUInteger)value;

@end
