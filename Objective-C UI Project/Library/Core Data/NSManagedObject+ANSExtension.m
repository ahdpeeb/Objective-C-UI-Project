//
//  NSManagedObject+ANSExtension.m
//  Objective-C UI Project
//
//  Created by Nikola Andriiev on 04.10.16.
//  Copyright © 2016 Andriiev.Mykola. All rights reserved.
//

#import "NSManagedObject+ANSExtension.h"

@implementation NSManagedObject (ANSExtension)

- (void)setCustomValue:(id)value forKey:(NSString *)key {
    [self willChangeValueForKey:key];
    [self setPrimitiveValue:value forKey:key];
    [self didChangeValueForKey:key];
}

- (id)customValue:(id)value forKey:(NSString *)key {
    [self willAccessValueForKey:key];
    id resultValue = [self primitiveValueForKey:key];
    [self didAccessValueForKey:key];
    
    return resultValue;
}

- (void)setCustomValue:(id)value inMutableSetForKey:(NSString *)key {
    
}

- (void)removeCustomValue:(id)value inMutableSetForKey:(NSString *)key {

}

- (void)addCustomValues:(NSSet *)values inMutableSetForKey:(NSString *)key {

}
- (void)removeCustomValues:(NSSet *)values inMutableSetForKey:(NSString *)key {

}

@end
