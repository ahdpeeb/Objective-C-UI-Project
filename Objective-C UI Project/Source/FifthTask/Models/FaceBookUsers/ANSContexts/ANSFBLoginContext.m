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
#pragma mark Reloaded Methods

- (NSString *)graphPathInit {
    return kANSme;
}

- (NSString *)HTTPMethodInit {
    return kANSGet;
}

- (NSDictionary *)parametresInit {
    return @{kANSFields: kANSme};
}

- (void)fillModelFromResult:(NSDictionary *)result {
    ANSFBUser *user = self.model;
    if (user.state == ANSUserDidLoadID) {
        return;
    }
    
    user.ID = [[result objectForKeyedSubscript:kANSID] doubleValue];
    user.state = ANSUserDidLoadID;
}

@end
