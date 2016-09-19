//
//  ANSLocalImageModel.m
//  Objective-C UI Project
//
//  Created by Nikola Andriiev on 14.09.16.
//  Copyright © 2016 Andriiev.Mykola. All rights reserved.
//

#import "ANSLocalImageModel.h"

#import "ANSImageModel+ANSPrivatExtension.h"

#import "NSFileManager+ANSExtension.h"

@implementation ANSLocalImageModel

#pragma mark -
#pragma mark Accsessors

- (NSString *)imageName {
    @synchronized(self) {
        return self.url.lastPathComponent;
    }
}

- (NSString *)imagePath {
    @synchronized(self) {
        return self.url.path;
    }
}

#pragma mark -
#pragma mark Privat methods

- (void)performLoading {
    UIImage *image = [UIImage imageWithContentsOfFile:self.imagePath];
    if (image) {
        [self.storage cacheObject:self forKey:self.imageName];
    }
    
    self.image = image;
    self.state = image ? ANSLoadableModelDidLoad : ANSLoadableModelDidFailLoading;
}
    
@end
