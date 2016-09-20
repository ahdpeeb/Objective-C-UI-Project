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
    ANSCacheStorage *cache = [ANSCacheStorage sharedStorage];
    
    id model = [cache objectForKey:url];
    if (model) {
        return model;
    }
    
    Class cls = url.fileURL ? [ANSLocalImageModel class] : [ANSInternetImageModel class];
    model = [[cls alloc] initWithURL:url];
    
    [cache cacheObject:model forKey:url];
    
    return model;
}

#pragma mark -
#pragma mark Initialization and deallocation

- (instancetype)initWithURL:(NSURL *)url {
    ANSInvalidIdentifierExceprionRaise(ANSImageModel);
    self = [super init];
    self.url = url;
    
    return self;
}

- (void)dealloc {
    
}

#pragma mark -
#pragma mark Public methods

@end