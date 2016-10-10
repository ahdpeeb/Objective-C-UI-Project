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
    return [NSString stringWithFormat:@"%lld", self.model.idNumber];
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

- (void)fillModelFromResult:(NSDictionary <ANSJSONRepresentation> *)result {
    [self userFromResult:result];
}

- (ANSUser *)userFromResult:(NSDictionary *)result {
    ANSUser *user = self.model;
    user.gender = result[kANSGender];
   
    [user refresh];
    NSLog(@"bla bla lba"); 
    user.state = ANSUserDidLoadDetails;
    
    return user;
}

@end
