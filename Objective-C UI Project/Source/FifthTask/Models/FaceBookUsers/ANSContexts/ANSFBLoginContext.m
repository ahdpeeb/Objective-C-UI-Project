//
//  ANSFBLoginContext.m
//  Objective-C UI Project
//
//  Created by Nikola Andriiev on 25.09.16.
//  Copyright © 2016 Andriiev.Mykola. All rights reserved.
//

#import "ANSFBLoginContext.h"

#import "ANSFBUser.h"
#import "ANSFBConstatns.h"

@implementation ANSFBLoginContext

#pragma mark -
#pragma mark Private Methods (reloaded)

- (NSString *)graphPath {
    return kANSMe;
}

- (NSString *)HTTPMethod {
    return kANSGet;
}

- (NSDictionary *)parametres {
    return @{kANSFields: kANSID};
}

- (void)fillModelFromResult:(NSDictionary *)result {
    ANSFBUser *user = self.model;
    user.ID = ((NSString *)result[kANSID]).longLongValue;
    user.state = ANSUserDidLoadID;
}

- (void)notifyIfLoadingFailed {
    ANSFBUser *user = self.model;
    user.state = ANSUserDidFailLoading;
}

- (void)notifyIfLoaded {
    ANSFBUser *user = self.model;
    if (user.state == ANSUserDidLoadID) {
        [user notifyOfStateChange:ANSUserDidLoadID];
    }
}

@end
