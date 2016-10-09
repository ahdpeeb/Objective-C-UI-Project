//
//  ANSLoginInterection.h
//  Objective-C UI Project
//
//  Created by Nikola Andriiev on 03.10.16.
//  Copyright © 2016 Andriiev.Mykola. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ANSUser;

@interface ANSLoginInterection : NSObject
@property (nonatomic, readonly) ANSUser *user;

+ (instancetype)interectionWithUser:(ANSUser *)user;

- (instancetype)initWithUser:(ANSUser *)user;

- (void)execute;

@end
