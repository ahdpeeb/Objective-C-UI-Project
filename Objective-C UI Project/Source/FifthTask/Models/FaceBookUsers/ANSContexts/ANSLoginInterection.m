//
//  ANSLoginInterection.m
//  Objective-C UI Project
//
//  Created by Nikola Andriiev on 03.10.16.
//  Copyright © 2016 Andriiev.Mykola. All rights reserved.
//

#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>

#import "ANSLoginInterection.h"

#import "ANSFBUser.h"

@interface ANSLoginInterection ()
@property (nonatomic, strong) ANSFBUser *user;

@end

@implementation ANSLoginInterection

#pragma mark -
#pragma mark Class methods

+ (instancetype)interectionWithUser:(ANSFBUser *)user {
    return [[self alloc] initWithUser:user];
}

#pragma mark -
#pragma mark Initialization and deallocation

- (instancetype)initWithUser:(ANSFBUser *)user {
    self = [super init];
    self.user = user;
    
    return self;
}

#pragma mark -
#pragma mark Public methods

- (void)execute {
    FBSDKAccessToken *token = [FBSDKAccessToken currentAccessToken];
    if (token) {
        ANSFBUser *user = self.user;
        user.ID = (NSUInteger)[token.userID integerValue];
        user.state = ANSUserDidLoadID;
    }
}

@end
