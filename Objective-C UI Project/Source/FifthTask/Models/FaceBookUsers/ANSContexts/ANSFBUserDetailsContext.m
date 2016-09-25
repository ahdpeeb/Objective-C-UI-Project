//
//  ANSUserLoadContext.m
//  Objective-C UI Project
//
//  Created by Nikola Andriiev on 23.09.16.
//  Copyright © 2016 Andriiev.Mykola. All rights reserved.
//
#import "ANSFBUserDetailsContext.h"

#import "ANSFBUser.h"

static NSString * const kANSFirstNameKey = @"first_name";
static NSString * const kANSLastNameKey = @"last_name";

@implementation ANSFBUserDetailsContext

#pragma mark -
#pragma mark Private Methods;

- (NSString *)graphPathInit; {
    ANSFBUser *user = self.model;
    return [NSString stringWithFormat:@"/{user-%lu}", (long)user.ID];
}

- (NSString *)HTTPMethodInit {
    return @"GET";
}

- (NSDictionary *)parametresInit {
   return @{@"fields": @"first_name, last_name, picture.type(large)"};
}

- (void)fillUserFromResult:(NSDictionary *)result {
    ANSFBUser *user = self.model;
    user.firstName = [result objectForKey:kANSFirstNameKey];
    user.lastName = [result objectForKey:kANSLastNameKey];
    
    NSDictionary * dataPicture = [[result objectForKey:@"picture"] objectForKey:@"data"];
    NSString *URLString = [dataPicture objectForKey:@"url"];
    user.imageUrl = [NSURL URLWithString:URLString];
    
    NSLog(@"user id = %lu, fullName - %@ %@, picture - %@",(long)user.ID,
          user.firstName,
          user.lastName,
          user.imageUrl);
}

@end
