//
//  ANSUserFriends.m
//  Objective-C UI Project
//
//  Created by Nikola Andriiev on 13.10.16.
//  Copyright © 2016 Andriiev.Mykola. All rights reserved.
//

#import "ANSUserFriends.h"

@implementation ANSUserFriends

- (NSArray<NSSortDescriptor *> *)sortDescriptors {
    NSSortDescriptor *descriptor = nil;
    descriptor = [NSSortDescriptor sortDescriptorWithKey:@"idNumber"
                                               ascending:YES];
    
    return @[descriptor];
}

- (NSPredicate *)predicate {
    return [NSPredicate predicateWithFormat:@"friends contains %@", self.model];
}

- (NSUInteger)batchCount {
    return 0;
}

@end
