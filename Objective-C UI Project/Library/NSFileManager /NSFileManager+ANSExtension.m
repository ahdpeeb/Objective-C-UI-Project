//
//  NSFileManager+ANSExtension.m
//  Objective-C UI Project
//
//  Created by Nikola Andriiev on 24.08.16.
//  Copyright © 2016 Andriiev.Mykola. All rights reserved.
//

#import "NSFileManager+ANSExtension.h"
#import <Foundation/NSPathUtilities.h>

static NSString * const kANSPlist = @".plist";

@implementation NSFileManager (ANSExtension)

- (NSString *)pathToDirectory:(NSSearchPathDirectory)directory {
    return [NSSearchPathForDirectoriesInDomains(directory, NSUserDomainMask, YES) firstObject];
}

- (NSString *)pathToDocumentDirectory {
   return [self pathToDirectory:NSDocumentDirectory];
}

- (NSString *)pathToApplicationDirectory {
    return [self pathToDirectory:NSApplicationDirectory];
}

- (NSString *)pathToFile:(NSString *)file inDirectory:(NSSearchPathDirectory)directory  {
    NSString *directoryPath = [self pathToDirectory:directory];
    return [directoryPath stringByAppendingPathComponent:file];
}

- (BOOL)isExistsFile:(NSString *)file inDirectory:(NSSearchPathDirectory)directory {
    NSString *filePath = [self pathToFile:file inDirectory:directory];
    return [self fileExistsAtPath:filePath];
}

- (NSString *)directoryWithName:(NSString *)name inDirectory:(NSSearchPathDirectory)directory {
    NSString *directoryPath = [self pathToFile:name inDirectory:directory];
    if (![self fileExistsAtPath:directoryPath]) {
        NSError *error = nil;
        BOOL success = [self createDirectoryAtPath:directoryPath
        withIntermediateDirectories:NO
                         attributes:nil
                              error:&error];
        
        if(!success) {
            NSLog(@"[ERROR] %@ (%@)",error, directoryPath);
        }
    }
    
    return directoryPath;
}

- (void)removeFile:(NSString *)file fromDirectory:(NSSearchPathDirectory)directory {
    NSString *documentsPath = [self pathToDirectory:directory];
    NSString *filePath = [documentsPath stringByAppendingPathComponent:file];
    NSError *error = nil;
        if (![self removeItemAtPath:filePath error:&error]) {
        NSLog(@"[Error] %@ (%@)", error, filePath);
    }
}

- (BOOL)copyFileAtPath:(NSString *)filePath toDirectory:(NSSearchPathDirectory)directory {
    BOOL success = NO;
    if ([self fileExistsAtPath:filePath]) {
        NSString *directoryPath = [self pathToDirectory:directory];
        NSString *newPath = [directoryPath stringByAppendingPathComponent:filePath.lastPathComponent];
        NSError *error = nil;
        success = [self copyItemAtPath:filePath toPath:newPath error:&error];
        if (!success) {
            NSLog(@"[ERROR] %@", error);
        }
    }
    
    return success;
}

- (NSString *)pathToPlistFile:(NSString *)file
                  inDirectory:(NSSearchPathDirectory)directory {
    NSString *fullPlistName = [file stringByAppendingString:kANSPlist];
    NSString *filePath = [self pathToFile:fullPlistName inDirectory:directory];
    if (![self fileExistsAtPath:filePath]) {
         NSString *resourcePath = [[[NSBundle mainBundle] resourcePath]
                                   stringByAppendingPathComponent:fullPlistName];
        
        BOOL success = [self copyFileAtPath:resourcePath toDirectory:directory];
        if (!success) {
            return nil;
        }
    }
    
    return filePath;
}

- (NSArray <NSString *> *)fileNamesAtPath:(NSString *)path {
    NSMutableArray *fileNames = nil;
    NSArray *filePaths = [self contentsOfDirectoryAtPath:path error:nil];
    for (NSString *filePath in filePaths) {
        [fileNames addObject:filePath.lastPathComponent];
    }
    
    return [fileNames copy];
}

@end
