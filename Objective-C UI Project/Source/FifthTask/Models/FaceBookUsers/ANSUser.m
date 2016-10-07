//
//  ANSUser.m
//  Objective-C UI Project
//
//  Created by Nikola Andriiev on 07.10.16.
//  Copyright © 2016 Andriiev.Mykola. All rights reserved.
//

#import "ANSUser.h"

#import "ANSRandom.h"
#import "NSString+ANSExtension.h"

@implementation ANSUser

@synthesize fullName;
@synthesize imageUrl;

#pragma mark -
#pragma mark Accsessors 

- (NSURL *)imageUrl {
    return [NSURL URLWithString:self.imageURL];
}

- (NSString *)fullName {
    return [NSString stringWithFormat:@"%@ %@", self.firstName, self.lastName];
}

#pragma mark -
#pragma mark Public methods

- (void)fillWithRandom {
    self.idNumber = ANSRandomIntegerWithValues(10000, 99999);
    self.firstName = [NSString randomStringWithLength:5
                                             alphabet:[NSString alphanumericAlphabet]];
    
    self.firstName = [NSString randomStringWithLength:5
                                             alphabet:[NSString alphanumericAlphabet]];
}

@end
