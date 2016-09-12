//
//  UIImage+ANSExtension.m
//  Objective-C UI Project
//
//  Created by Nikola Andriiev on 11.09.16.
//  Copyright © 2016 Andriiev.Mykola. All rights reserved.
//

#import <Foundation/NSPathUtilities.h>
#import <Foundation/NSURL.h>

#import "UIImage+ANSExtension.h"

#import "NSFileManager+ANSExtension.h"

@implementation UIImage (ANSExtension)

#pragma mark -
#pragma mark Private methods

- (NSString *)imagePathWithName:(NSString *)name
                        quality:(CGFloat)quality
           isJPEGRepresentation:(BOOL)representation
{
    NSString *correctName = [[name stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLUserAllowedCharacterSet]] lowercaseString];
    NSString *fullName = [correctName stringByAppendingPathExtension:representation ? @"jpeg" : @"png"];
    
    NSFileManager *filemanager = [NSFileManager defaultManager];
    NSString *imagePath = [filemanager pathToFile:fullName inSearchPathDirectory:NSDocumentDirectory];
    if ([filemanager fileExistsAtPath:imagePath]) {
        NSLog(@"[ERROR] This file already exist");
        return nil;
    }
    
    NSData *imageData = representation ? UIImageJPEGRepresentation(self, quality) : UIImagePNGRepresentation(self);
    BOOL isSuccsess = [imageData writeToFile:imagePath atomically:YES];
    
    return isSuccsess ? imagePath : nil;
}

#pragma mark -
#pragma mark Public methods

- (NSString *)pathToJPEGRepresentationWithName:(NSString *)name quality:(CGFloat)quality {
   return [self imagePathWithName:name quality:quality isJPEGRepresentation:YES];
}

- (NSString *)pathToPNGRepresentationWithName:(NSString *)name {
   return [self imagePathWithName:name quality:0 isJPEGRepresentation:NO];
}

@end
