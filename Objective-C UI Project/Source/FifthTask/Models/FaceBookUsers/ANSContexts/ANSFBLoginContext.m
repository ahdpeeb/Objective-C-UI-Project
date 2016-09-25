//
//  ANSFBLoginContext.m
//  Objective-C UI Project
//
//  Created by Nikola Andriiev on 25.09.16.
//  Copyright © 2016 Andriiev.Mykola. All rights reserved.
//

#import "ANSFBLoginContext.h"

#import "ANSFacebookUser.h"

@implementation ANSFBLoginContext

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
    ANSFacebookUser *user = self.model;
    if (user.state == ANSUserDidLoadID) {
        return;
    }
    
    NSString *ID = (NSString *)[result objectForKeyedSubscript:@"id"];
    user.ID = ID.intValue;
    user.state = ANSUserDidLoadID;
}

@end
