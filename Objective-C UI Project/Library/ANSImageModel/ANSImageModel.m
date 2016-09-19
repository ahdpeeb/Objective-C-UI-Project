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
    ANSImageModel *model = (url.isFileURL) ? [[ANSLocalImageModel alloc] initWithURL:url]
                                        : [[ANSInternetImageModel alloc] initWithURL:url];
    
    id cachedModel = [model.cache objectForKey:model.imageName];
    if (cachedModel) {
        model = cachedModel;
    }
    
    return model;
}

#pragma mark -
#pragma mark Initialization and deallocation

- (instancetype)initWithURL:(NSURL *)url {
    ANSInvalidIdentifierExceprionRaise(ANSImageModel);
    self = [super init];
    
    self.url = url;
    self.cache = [ANSCacheStorage cacheStorage];
    
    return self;
}

- (void)dealloc {
    
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