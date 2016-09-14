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
#import "ANSImageModel_ANSPrivatExtension.h"

#import "ANSMacros.h"

@interface ANSImageModel ()

- (void)initCacheStorage;
- (ANSImageModel *)imageModelIfImageExist;
- (void)cacheImageModel;

@end

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
    [self initCacheStorage];
    
    ANSImageModel *cachedModel = [self imageModelIfImageExist];
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

- (void)initCacheStorage {
    static NSMapTable * imagesModelStorage = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        imagesModelStorage = [NSMapTable mapTableWithKeyOptions:NSPointerFunctionsStrongMemory
                                                   valueOptions:NSPointerFunctionsWeakMemory];
    });
    
    self.cacheStorage = imagesModelStorage;
}

- (UIImage *)loadImage {
    [self doesNotRecognizeSelector:_cmd];
    
    return nil;
}

- (ANSImageModel *)imageModelIfImageExist {
    @synchronized(self) {
        return [self.cacheStorage objectForKey:self.imageName];
    }
}

- (void)cacheImageModel {
    @synchronized(self) {
        if (![self imageModelIfImageExist]) {
            [self.cacheStorage setObject:self forKey:self.imageName];
        }
    }
}

#pragma mark -
#pragma mark Public Methods

- (void)performLoading {
    UIImage *image = [self loadImage];
    if (image) {
        [self cacheImageModel];
        NSLog(@"ImageNameInfo - %@", self.imageName);
        NSLog(@"Object INFO - %@", [self.cacheStorage objectForKey:self.imageName]);
    }
    
    self.image = image;
    self.state = image ? ANSLoadableModelDidLoad : ANSLoadableModelDidFailLoading;
}

@end