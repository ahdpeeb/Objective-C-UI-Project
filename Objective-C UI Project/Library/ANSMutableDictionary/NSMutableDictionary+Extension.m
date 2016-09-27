//
//  NSMutableDictionary+Extension.m
//  Objective-C UI Project
//
//  Created by Nikola Andriiev on 27.09.16.
//  Copyright © 2016 Andriiev.Mykola. All rights reserved.
//

#import "NSMutableDictionary+Extension.h"

@implementation NSMutableDictionary (Extension)

- (instancetype)JSONRepresentation {
    @synchronized (self) {
        NSArray *keys = [self allKeysForObject:[NSNull null]];
        [self removeObjectsForKeys:keys];
        return self;
    }
}

@end
