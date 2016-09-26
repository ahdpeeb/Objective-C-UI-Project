//
//  ANSUserLoadContext.m
//  Objective-C UI Project
//
//  Created by Nikola Andriiev on 23.09.16.
//  Copyright © 2016 Andriiev.Mykola. All rights reserved.
//
#import "ANSFBUserDetailsContext.h"

#import "ANSFBUser.h"
#import "ANSFBConstatns.h"

@implementation ANSFBUserDetailsContext

#pragma mark -
#pragma mark Private Methods;

- (NSString *)graphPathInit; {
    NSUInteger value = ((ANSFBUser *)self.model).ID;
    return [NSString stringWithFormat:@"%ld", value];
}

- (NSString *)HTTPMethodInit {
    return kANSGet;
}

- (NSDictionary *)parametresInit {
    return @{kANSFields:[NSString stringWithFormat:@"%@, %@, %@",
                         kANSHometown,
                         kANSGender,
                         kANSEmail]};
}

- (void)fillModelFromResult:(NSDictionary *)result {
    ANSFBUser *user = self.model;
    user.email = result[kANSEmail];
    user.gender = result[kANSGender];
    
    user.state = ANSUserDidLoadDetails;
}

@end
