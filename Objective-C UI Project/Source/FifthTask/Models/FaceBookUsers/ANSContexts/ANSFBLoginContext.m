//
//  ANSFBLoginContext.m
//  Objective-C UI Project
//
//  Created by Nikola Andriiev on 25.09.16.
//  Copyright © 2016 Andriiev.Mykola. All rights reserved.
//

#import "ANSFBLoginContext.h"

#import "ANSFBUser.h"

@implementation ANSFBLoginContext

#pragma mark -
#pragma mark Reloaded Methods

- (NSString *)graphPathInit {
    return @"me";
}

- (NSString *)HTTPMethodInit {
    return @"GET";
}

- (NSDictionary *)parametresInit {
    return @{@"fields": @"id"};
}

- (void)fillModelFromResult:(NSDictionary *)result {
    ANSFBUser *user = self.model;
    if (user.state == ANSUserDidLoadID) {
        return;
    }
    
    NSString *ID = (NSString *)[result objectForKeyedSubscript:@"id"];
    user.ID = ID.intValue;
    user.state = ANSUserDidLoadID;
}

@end
