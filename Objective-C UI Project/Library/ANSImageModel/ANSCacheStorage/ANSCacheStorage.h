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
+ (instancetype)sharedStorage;

- (void)cacheObject:(id)object forKey:(id)key;
- (void)removeCachedObjectForKey:(id)key;
- (id)objectForKey:(id)key;

@end
