//
//  ANSInternetImageModel.m
//  Objective-C UI Project
//
//  Created by Nikola Andriiev on 14.09.16.
//  Copyright © 2016 Andriiev.Mykola. All rights reserved.
//

#import "ANSInternetImageModel.h"

#import "ANSImageModel.h"
#import "ANSImageModel+ANSPrivatExtension.h"

#import "ANSMacros.h"
#import "ANSRandom.h"
#import "NSFileManager+ANSExtension.h"
#import "UIImage+ANSExtension.h"

@interface ANSImageModel ()
@property (nonatomic, strong) NSURLSessionTask *task;

- (BOOL)isImageCached;
- (void)removeCorruptedFile;
- (UIImage *)imageFromUrl:(NSURL *)url;
- (void)loadImage;

@end

@implementation ANSInternetImageModel

@synthesize task = _task;

#pragma mark -
#pragma mark Initialization and deallocation 

- (void)dealloc {
    self.task = nil;
}

#pragma mark -
#pragma mark Accsessors

- (NSString *)imageName {
    NSCharacterSet *characterSet = [NSCharacterSet URLUserAllowedCharacterSet];
    return [self.url.absoluteString stringByAddingPercentEncodingWithAllowedCharacters:characterSet];
}

- (NSString *)imagePath {
    return [[NSFileManager documentDirectoryPath] stringByAppendingPathComponent:self.imageName];
}

- (void)setTask:(NSURLSessionTask *)task {
    if (_task != task) {
        
        [_task cancel];
        _task = task;
        [_task resume];
    }
}


#pragma mark -
#pragma mark Privat methods

- (BOOL)isImageCached {
    NSFileManager *fileManager = [NSFileManager defaultManager];
    return [fileManager fileExists:self.imageName inSearchPathDirectory:NSDocumentDirectory];
}

- (void)removeCorruptedFile {
    if ([self isImageCached]) {
        BOOL isRemoved = [[NSFileManager defaultManager] removeFile:self.imageName
                         fromSearchPathDirectory:NSDocumentDirectory];
        
        isRemoved ? NSLog(@"Removed [OK]") : NSLog(@"Removed [ERROR]");
    }
}

- (UIImage *)imageFromUrl:(NSURL *)url {
    return [UIImage imageWithData:[NSData dataWithContentsOfURL:url]];
}

- (void)performLoading {
    if ([self isImageCached]) {
        [super performLoading];
        if (self.image) {
            [self removeCorruptedFile];
        }
    }
    
    [self loadImage];
}

- (void)loadImage {
    __block NSFileManager *manager = [NSFileManager defaultManager];
    self.task = [[NSURLSession sharedSession]
                 downloadTaskWithURL:self.url
                   completionHandler:^(NSURL *location, NSURLResponse *response, NSError *error) {
                       if (!error) {
                           NSError *moveError = nil;
                           [manager moveItemAtURL:location
                                            toURL:[NSURL URLWithString:self.imagePath]
                                            error:&moveError];
                           
                           if (moveError) {
                               self.image = [self imageFromUrl:self.url];
                           }
                           
                           self.image = [UIImage imageWithContentsOfFile:self.imagePath];
                        }
                   }];
}

@end
