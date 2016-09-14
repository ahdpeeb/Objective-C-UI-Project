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

@interface ANSImageModel ()
@property (nonatomic, strong) NSMapTable *imagesStorage;

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
    if ([self class] == [ANSImageModel class]) {
        [NSException raise:@"Invalid identifier" format:@"You should never call init method for ANSImageModel"];
    }
    
    self = [super init];
    self.url = url;
    [self initImagesStorage];
    
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

- (void)initImagesStorage {
    static NSMapTable * imagesStorage = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        imagesStorage = [NSMapTable mapTableWithKeyOptions:NSPointerFunctionsStrongMemory valueOptions:NSPointerFunctionsWeakMemory];
    });
    
    self.imagesStorage = imagesStorage;
}

- (UIImage *)loadImage {
    [self doesNotRecognizeSelector:_cmd];
    
    return nil;
}

- (UIImage *)imageIsExist {
    return [self.imagesStorage objectForKey:self.imageName];
}

#pragma mark -
#pragma mark Public Methods

- (void)performLoading {
    UIImage *image = [self imageIsExist];
    if (image) {
        self.image = image;
    } else {
        self.image = [self loadImage];
    }
    
    self.state = self.image ? ANSLoadableModelDidLoad : ANSLoadableModelDidFailLoading;
}

@end