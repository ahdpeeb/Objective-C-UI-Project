//
//  ANSContextModel.h
//  Objective-C UI Project
//
//  Created by Nikola Andriiev on 23.09.16.
//  Copyright © 2016 Andriiev.Mykola. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "ANSFacebookUser.h"

@interface ANSFBUserContext : NSObject
@property (nonatomic, readonly) ANSFacebookUser *user;

- (instancetype)initWitUser:(ANSFacebookUser *)user;

- (void)executeForUserState:(ANSUserState)state;
- (void)cancel;

- (void)fillUserFromResult:(NSDictionary *)result;

// next methods need to me reloaded in child classes:
// return's graphPath string
- (NSString *)graphPathInit;

//return value must be: @"GET", @"POST", @"DELETE". default is @"GET"
- (NSString *)HTTPMethodInit;

// return's dictionaty with parametres;
- (NSDictionary *)parametresInit;

@end
