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

#import "ANSUser.h"

@interface ANSLoginInterection ()
@property (nonatomic, strong) ANSUser *user;

@end

@implementation ANSLoginInterection

#pragma mark -
#pragma mark Class methods

+ (instancetype)interectionWithUser:(ANSUser *)user {
    return [[self alloc] initWithUser:user];
}

#pragma mark -
#pragma mark Initialization and deallocation

- (instancetype)initWithUser:(ANSUser *)user {
    self = [super init];
    self.user = user;
    
    return self;
}

#pragma mark -
#pragma mark Public methods

- (void)execute {
    FBSDKAccessToken *token = [FBSDKAccessToken currentAccessToken];
    if (token) {
        ANSUser *user = self.user;
        user.idNumber = (NSUInteger)[token.userID integerValue];
        user.state = ANSUserDidLoadID;
    }
}

@end
