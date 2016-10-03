//
//  ANSLoginInterection.h
//  Objective-C UI Project
//
//  Created by Nikola Andriiev on 03.10.16.
//  Copyright © 2016 Andriiev.Mykola. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ANSFBUser;

@interface ANSLoginInterection : NSObject
@property (nonatomic, readonly) ANSFBUser *user;

+ (instancetype)interectionWithUser:(ANSFBUser *)user;

- (instancetype)initWithUser:(ANSFBUser *)user;

- (void)execute;

@end
