//
//  ANSInternetImageModel.m
//  Objective-C UI Project
//
//  Created by Nikola Andriiev on 14.09.16.
//  Copyright © 2016 Andriiev.Mykola. All rights reserved.
//

#import "ANSInternetImageModel.h"

#import "ANSImageModel.h"

#import "ANSMacros.h"
#import "ANSRandom.h"
#import "NSFileManager+ANSExtension.h"
#import "UIImage+ANSExtension.h"

@interface ANSImageModel ()

- (void)downloadImageToFileSystem;
- (UIImage *)internetImage;
- (void)removeCorruptedFile;
- (UIImage *)loadImage;

@end

@implementation ANSInternetImageModel

#pragma mark -
#pragma mark Accsessors

- (NSString *)imageName {
    NSCharacterSet *characterSet = [NSCharacterSet URLUserAllowedCharacterSet];
    return [self.url.absoluteString stringByAddingPercentEncodingWithAllowedCharacters:characterSet];
}

- (NSString *)imagePath {
    return [[NSFileManager documentDirectoryPath] stringByAppendingPathComponent:self.imageName];
}

#pragma mark -
#pragma mark Privat methods

- (void)downloadImageToFileSystem {
    if (![[NSFileManager defaultManager] fileExistsAtPath:self.imagePath]) {
        NSURLSessionDownloadTask *downloadTask = [[NSURLSession sharedSession] downloadTaskWithURL:self.url];
        [downloadTask resume];
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

- (UIImage *)loadImage {
    [self downloadImageToFileSystem];
    UIImage *image = [UIImage imageWithContentsOfFile:self.imagePath];
    
    if (!image) {
        // if !error && !image
        [self removeCorruptedFile];
    } else if (!image) {
        // if error && !image
        image = [self internetImage];
    }
    
    return image;
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
    NSLog(@"didFinishDownloadingToURL = notification");
}

@end
