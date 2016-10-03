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
#pragma mark Private Methods (reloaded);

- (NSString *)graphPath; {
    return [NSString stringWithFormat:@"%ld", ((ANSFBUser *)self.model).ID];
}

- (NSString *)HTTPMethod {
    return kANSGet;
}

- (NSDictionary *)parametres {
    return @{kANSFields:[NSString stringWithFormat:@"%@, %@, %@",
                         kANSHometown,
                         kANSGender,
                         kANSEmail]};
}

- (void)loadFromCache {
    ANSFBUser *user = self.model;
    user.state = ANSUserDidFailLoading;
}

- (BOOL)isModelLoaded {
   return [super isModelLoadedWithState:ANSUserDidLoadDetails];
}

- (void)fillModelFromResult:(NSDictionary *)result {
    ANSFBUser *user = self.model;
    [super fillUser:user fromResult:result];
    user.gender = result[kANSGender];
    user.email = result[kANSEmail];
   
    [user save];
    user.state = ANSUserDidLoadDetails;
}

@end
