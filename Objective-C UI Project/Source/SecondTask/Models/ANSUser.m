//
//  ANSUser.m
//  Objective-C UI Project
//
//  Created by Nikola Andriiev on 21.07.16.
//  Copyright © 2016 Andriiev.Mykola. All rights reserved.
//

#import "ANSUser.h"

@implementation ANSUser

@dynamic fullName;
@dynamic userImage;

#pragma mark -
#pragma mark Initialization

- (instancetype)initWithName:(NSString*)name
                     surname:(NSString*)surname
{
    self = [super init];
    if (self) {
        self.name = name;
        self.surname = surname;
    }
    
    return self;
}

#pragma mark -
#pragma mark Accsessors

- (NSString *)getFullName {
    return [NSString stringWithFormat:@"%@ %@", self.name, self.surname];
}

- (UIImage *)userImage {
    NSString *path = [[NSBundle mainBundle] pathForResource:@"homer_simpson31" ofType:@"jpg"];
    
    return [UIImage imageWithContentsOfFile:path];
}

@end
