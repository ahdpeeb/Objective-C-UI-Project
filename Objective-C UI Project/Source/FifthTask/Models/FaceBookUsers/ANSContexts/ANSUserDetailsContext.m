//
//  ANSUserLoadContext.m
//  Objective-C UI Project
//
//  Created by Nikola Andriiev on 23.09.16.
//  Copyright © 2016 Andriiev.Mykola. All rights reserved.
//
#import "ANSUserDetailsContext.h"

#import "ANSUser.h"
#import "ANSFBConstatns.h"

#import "NSManagedObject+ANSExtension.h"

@implementation ANSUserDetailsContext

#pragma mark -
#pragma mark Private Methods (reloaded);

- (NSString *)graphPath; {
    return [NSString stringWithFormat:@"%lld", ((ANSUser *)self.model).idNumber];
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
    ANSUser *user = self.model;
    user.state = ANSUserDidFailLoading;
}

- (BOOL)isModelLoaded {
   return [super isModelLoadedWithState:ANSUserDidLoadDetails];
}

- (ANSUser *)userFromResult:(NSDictionary *)result {
    ANSUser *user = [super userFromResult:result];
    user.gender = result[kANSGender];
   
    [user save];
    user.state = ANSUserDidLoadDetails;
    
    return user;
}

@end
