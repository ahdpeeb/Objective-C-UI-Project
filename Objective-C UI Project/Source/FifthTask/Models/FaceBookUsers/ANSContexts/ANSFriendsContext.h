//
//  ANSFBFriendsContext.h
//  Objective-C UI Project
//
//  Created by Nikola Andriiev on 25.09.16.
//  Copyright © 2016 Andriiev.Mykola. All rights reserved.
//

#import "ANSFBContext.h"

@class ANSUser;
@class ANSUserFriends;

@interface ANSFriendsContext : ANSFBContext
@property (nonatomic, readonly) ANSUserFriends *userFriends;

- (instancetype)initWithUser:(ANSUser *)user
                 userFriends:(ANSUserFriends *)userFriends;

//method for subclasses
- (ANSUser *)userFromResult:(NSDictionary *)result;

- (BOOL)isModelLoadedWithState:(NSUInteger)state;

@end
