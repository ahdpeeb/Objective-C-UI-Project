//
//  ANSDataCollection.m
//  Objective-C UI Project
//
//  Created by Nikola Andriiev on 24.07.16.
//  Copyright © 2016 Andriiev.Mykola. All rights reserved.
//
#import <UIKit/UIKit.h>

#import "ANSUsersCollection.h"

#import "ANSUser.h"

@implementation ANSUsersCollection

#pragma mark -
#pragma mark sorting ANSData by name

- (NSArray *)descendingSortedUsers {
    NSMutableArray *users = [NSMutableArray arrayWithArray:self.objects];
    [users sortUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        if ([obj1 isKindOfClass:[ANSUser class]] && [obj2 isKindOfClass:[ANSUser class]]) {
             return [[obj1 string] compare:[obj2 string]];
        }
        
        return (NSComparisonResult)NSOrderedDescending;
    }];
    
    return users;
}

- (ANSUsersCollection *)sortedCollectionByString:(NSString *)filterStrirng {
    
    ANSUsersCollection *newCollection = [ANSUsersCollection new];
    for (ANSUser *data in self) {
        if ((filterStrirng.length > 0) && [data.string rangeOfString:filterStrirng options:NSCaseInsensitiveSearch].location == NSNotFound) {
            continue;
        } else {
            [newCollection addData:data];
        }
    }
    
    return newCollection;
}

@end
