//
//  NSObject+ANSObjectExtension.m
//  Objective-c course
//
//  Created by Nikola Andriiev on 02.06.16.
//  Copyright © 2016 Anfriiev.Mykola. All rights reserved.
//

#import "NSObject+ANSExtension.h"

@implementation NSObject (ANSExtension)

+ (instancetype)object {
    return [[[self alloc] init] autorelease];
}

@end
