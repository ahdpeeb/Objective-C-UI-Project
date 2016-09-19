//
//  ANSCacheStorage.h
//  Objective-C UI Project
//
//  Created by Nikola Andriiev on 18.09.16.
//  Copyright © 2016 Andriiev.Mykola. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ANSCacheStorage : NSObject
@property (nonatomic, assign, readonly) NSUInteger count;

//Designated initializar, sigleton object;
+ (instancetype)cacheStorage;

- (void)cacheObject:(id)object forKey:(NSString *)key;
- (void)removeCachedObjectForKey:(NSString *)key;
- (id)objectForKey:(NSString *)key;

@end
