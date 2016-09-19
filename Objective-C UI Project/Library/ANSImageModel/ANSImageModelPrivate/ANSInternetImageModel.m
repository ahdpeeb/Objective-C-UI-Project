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

- (void)downloadImageToFileSystem;
- (UIImage *)internetImage;
- (void)removeCorruptedFile;
- (void)loadImage:(NSError *)error;

@end

@implementation ANSInternetImageModel

#pragma mark -
#pragma mark Initialization and deallocation 

- (void)dealloc {
    [[NSURLSession sharedSession] invalidateAndCancel];
}

#pragma mark -
#pragma mark Accsessors

- (NSString *)imageName {
    @synchronized(self) {
        NSCharacterSet *characterSet = [NSCharacterSet URLUserAllowedCharacterSet];
        return [self.url.absoluteString stringByAddingPercentEncodingWithAllowedCharacters:characterSet];
    }
}

- (NSString *)imagePath {
    @synchronized(self) {
        return [[NSFileManager documentDirectoryPath] stringByAppendingPathComponent:self.imageName];
    }
}

#pragma mark -
#pragma mark Privat methods

- (void)downloadImageToFileSystem {
    if (![[NSFileManager defaultManager] fileExistsAtPath:self.imagePath]) {
        NSURLSessionDownloadTask *downloadTask = [[NSURLSession sharedSession] downloadTaskWithURL:self.url];
        self.task = downloadTask;
        [downloadTask resume];
    } else {
        [self loadImage:nil];
    }
}

- (void)removeCorruptedFile {
    BOOL isRemoved = [[NSFileManager defaultManager] removeFile:self.imageName
                                        fromSearchPathDirectory:NSDocumentDirectory];
    
    isRemoved ? NSLog(@"Removed [OK]") : NSLog(@"Removed [ERROR]");
}

- (UIImage *)internetImage {
    return [UIImage imageWithData:[NSData dataWithContentsOfURL:self.url]];
}

- (void)loadImage:(NSError *)error {
    @synchronized(self) {
        UIImage *image = [UIImage imageWithContentsOfFile:self.imagePath];
        if (!image) {
            if (error) {
                image = [self internetImage];
            }
            
            [self removeCorruptedFile];
        }
        
        if (image) {
            [self.storage cacheObject:self forKey:self.imageName];
        }
        
        self.image = image;
        self.state = image ? ANSLoadableModelDidLoad : ANSLoadableModelDidFailLoading;
    }
}

- (void)performLoading {
    [self downloadImageToFileSystem];
}

#pragma mark -
#pragma mark protocol NSURLSessionDownloadDelegate

- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask
                              didFinishDownloadingToURL:(NSURL *)location
{
    NSError *error = nil;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    [fileManager moveItemAtURL:location
                         toURL:[NSURL URLWithString:self.imagePath]
                         error:&error];
    
    [self loadImage:error];
}

@end
