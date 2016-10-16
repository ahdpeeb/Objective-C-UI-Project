//
//  ANSUserFriends.m
//  Objective-C UI Project
//
//  Created by Nikola Andriiev on 13.10.16.
//  Copyright © 2016 Andriiev.Mykola. All rights reserved.
//

#import "ANSUserFriends.h"

#import "ANSUser.h"

@implementation ANSUserFriends

- (NSArray<NSSortDescriptor *> *)sortDescriptors {
    NSSortDescriptor *descriptor = nil;
    descriptor = [NSSortDescriptor sortDescriptorWithKey:@"idNumber"
                                               ascending:YES];
    
    return @[descriptor];
}

//- (NSPredicate *)fetchedPredicate {
//    ANSUser *user = (ANSUser *)self.model;
//////    @"SUBQUERY(tasks, $task, $task.completionDate != nil
////    return [NSPredicate predicateWithFormat:@"SUBQUERY(friends, $user, $user.firstName == nil];
//////    return [NSPredicate predicateWithFormat:@"friends CONTAINS[c] %@", user.firstName];
//}

@end
