//
//  ANSFBFriendsContext.h
//  Objective-C UI Project
//
//  Created by Nikola Andriiev on 25.09.16.
//  Copyright © 2016 Andriiev.Mykola. All rights reserved.
//

#import "ANSFBContext.h"

@class ANSUser;

@interface ANSFriendsContext : ANSFBContext

//method for subclasses
- (ANSUser *)userFromResult:(NSDictionary *)result;

- (BOOL)isModelLoadedWithState:(NSUInteger)state;

@end
