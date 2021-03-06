//
//  NSMutableDictionary+Extension.m
//  Objective-C UI Project
//
//  Created by Nikola Andriiev on 27.09.16.
//  Copyright © 2016 Andriiev.Mykola. All rights reserved.
//

#import "NSDictionary+Extension.h"

@implementation NSDictionary (Extension)

- (instancetype)JSONRepresentation {
    NSMutableDictionary *dictionary = [NSMutableDictionary new];
    for (id key in [self allKeys]) {
        id <ANSJSONRepresentation> object = self[key];
        [dictionary setValue:[object JSONRepresentation] forKey:key];
    }
    
    return [dictionary copy];
}

@end
