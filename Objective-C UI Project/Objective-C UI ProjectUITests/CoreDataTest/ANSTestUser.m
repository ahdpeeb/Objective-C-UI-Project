//
//  ANSTestUSer.m
//  Objective-C UI Project
//
//  Created by Nikola Andriiev on 06.10.16.
//  Copyright © 2016 Andriiev.Mykola. All rights reserved.
//

#import "ANSTestUser.h"

#import "NSString+ANSExtension.h"
#import "ANSRandom.h"

@implementation ANSTestUser

+ (instancetype)randomUser {
    ANSTestUser *result = [self new];
    result.firsName = [NSString randomStringWithLength:5 alphabet:[NSString lowercaseLetterAlphabet]];
    result.secondName = [NSString randomStringWithLength:5 alphabet:[NSString lowercaseLetterAlphabet]];
    
    result.age = ANSRandomUnsignedInteget(30);
    
    return result;
}


@end
