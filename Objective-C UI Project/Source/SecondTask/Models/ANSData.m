//
//  ANSUser.m
//  Objective-C UI Project
//
//  Created by Nikola Andriiev on 21.07.16.
//  Copyright © 2016 Andriiev.Mykola. All rights reserved.
//

#import "ANSData.h"

#import "NSString+ANSExtension.h"

static const NSUInteger kANSStringLength    = 10;
static NSString * const kANSImageName       = @"Gomer_2";
static NSString * const kANSImageFormat     = @"png";

@interface ANSData ()
@property (nonatomic, copy) NSString *mutableString;

@end

@implementation ANSData

@dynamic string;
@dynamic image;

#pragma mark -
#pragma mark Initialization and deallocation 

- (instancetype)init {
    self = [super init];
    if (self) {
        NSString *alphabet = [NSString alphanumericAlphabet];
        self.mutableString = [NSString randomStringWithLength:kANSStringLength alphabet:alphabet];
    }
    
    return self;
}

#pragma mark -
#pragma mark Accsessors

- (NSString *)string {
    return self.mutableString;
}

- (UIImage *)image {
    NSString *path = [[NSBundle mainBundle] pathForResource:kANSImageName ofType:kANSImageFormat];
    
    return [UIImage imageWithContentsOfFile:path];
}

@end
