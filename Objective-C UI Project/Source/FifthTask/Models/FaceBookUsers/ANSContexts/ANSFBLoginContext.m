//
//  ANSFBLoginContext.m
//  Objective-C UI Project
//
//  Created by Nikola Andriiev on 25.09.16.
//  Copyright © 2016 Andriiev.Mykola. All rights reserved.
//

#import "ANSFBLoginContext.h"

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

- (void)fillUserFromResult:(NSDictionary *)result {
    NSString *ID = (NSString *)[result objectForKeyedSubscript:@"id"];
    self.user.ID = ID.intValue;
}

@end
