//
//  NSManagedObject+ANSExtension.h
//  Objective-C UI Project
//
//  Created by Nikola Andriiev on 04.10.16.
//  Copyright © 2016 Andriiev.Mykola. All rights reserved.
//

#import <CoreData/CoreData.h>

@interface NSManagedObject (ANSExtension)

//coreDate defult set/get implementation for key
- (void)setCustomValue:(id)value forKey:(NSString *)key;
- (id)customValue:(id)value forKey:(NSString *)key;

- (void)setCustomValue:(id)value inMutableSetForKey:(NSString *)key;
- (void)removeCustomValue:(id)value inMutableSetForKey:(NSString *)key;

- (void)addCustomValues:(NSSet *)values inMutableSetForKey:(NSString *)key;
- (void)removeCustomValues:(NSSet *)values inMutableSetForKey:(NSString *)key;

@end
