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
#import "ANSJSONRepresentation.h"

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

- (void)notifyIfLoadingFailed {
    ANSFBUser *user = self.model;
    user.state = ANSUserDidFailLoading;
}

- (BOOL)notifyIfLoaded {
    ANSFBUser *user = self.model;
    if (user.state == ANSUserDidLoadID) {
        [user notifyOfStateChange:ANSUserDidLoadID];
        
        return YES;
    }
    
    return NO;
}

- (void)fillModelFromResult:(NSDictionary <ANSJSONRepresentation> *)result; {
    ANSFBUser *user = self.model;
    NSDictionary *parsedResult = [result JSONRepresentation];
    user.ID = [(NSString *)parsedResult[kANSID] doubleValue];
    user.state = ANSUserDidLoadID;
}

@end
