//
//  ANSUser.m
//  Objective-C UI Project
//
//  Created by Nikola Andriiev on 21.07.16.
//  Copyright © 2016 Andriiev.Mykola. All rights reserved.
//

#import "ANSData.h"

#import "NSString+ANSExtension.h"

@implementation ANSData

@dynamic string;
@dynamic image;

#pragma mark -
#pragma mark Accsessors

- (NSString *)getString {
    NSString *alphabet = [NSString alphanumericAlphabet];
    return [NSString randomStringWithLength:5 alphabet:alphabet];
}

- (UIImage *)getImage {
    NSString *path = [[NSBundle mainBundle] pathForResource:@"homer_simpson31" ofType:@"jpg"];
    
    return [UIImage imageWithContentsOfFile:path];
}

@end
