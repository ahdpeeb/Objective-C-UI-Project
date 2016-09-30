//
//  ANSFBFriendsContext.h
//  Objective-C UI Project
//
//  Created by Nikola Andriiev on 25.09.16.
//  Copyright © 2016 Andriiev.Mykola. All rights reserved.
//

#import "ANSFBContext.h"

@class ANSFBUser;

@interface ANSFBFriendsContext : ANSFBContext
@property (nonatomic, strong) ANSFBUser *user;

@end
