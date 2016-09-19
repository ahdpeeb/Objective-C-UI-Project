//
//  ANSImageModel.m
//  Objective-C UI Project
//
//  Created by Nikola Andriiev on 29.07.16.
//  Copyright © 2016 Andriiev.Mykola. All rights reserved.
//

#import "ANSImageModel.h"

#import "ANSLocalImageModel.h"
#import "ANSInternetImageModel.h"
#import "ANSImageModel+ANSPrivatExtension.h"

#import "ANSMacros.h"

@implementation ANSImageModel

@dynamic imageName;
@dynamic imagePath;

#pragma mark -
#pragma mark Class methods

+ (instancetype)imageFromURL:(NSURL *)url {
    if (url.isFileURL) {
        return [[ANSLocalImageModel alloc] initWithURL:url];
    }
    
    return [[ANSInternetImageModel alloc] initWithURL:url];
}

#pragma mark -
#pragma mark Initialization and deallocation

- (instancetype)initWithURL:(NSURL *)url {
    ANSInvalidIdentifierExceprionRaise(ANSImageModel);
    self = [super init];
    self.url = url;
    self.storage = [ANSCacheStorage cacheStorage];
    
    id cachedModel = [self.storage objectForKey:self.imageName];
    if (cachedModel) {
        self = cachedModel;
    }
    
    return self;
}

#pragma mark -
#pragma mark Accsessors

- (NSString *)imageName {
    [self doesNotRecognizeSelector:_cmd];
    
    return nil;
}

- (NSString *)imagePath {
    [self doesNotRecognizeSelector:_cmd];
    
    return nil;
}

#pragma mark -
#pragma mark Privat methods

- (UIImage *)loadImage {
    [self doesNotRecognizeSelector:_cmd];
    
    return nil;
}

#pragma mark -
#pragma mark Public Methods

- (void)performLoading {
    [self doesNotRecognizeSelector:_cmd]; 
}

@end