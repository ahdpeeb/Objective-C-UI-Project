//
//  NSFileManager+ANSExtension.m
//  Objective-C UI Project
//
//  Created by Nikola Andriiev on 24.08.16.
//  Copyright © 2016 Andriiev.Mykola. All rights reserved.
//

#import "NSFileManager+ANSExtension.h"
#import <Foundation/NSPathUtilities.h>

static NSString * const kANSPlist = @"data.plist";

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

- (BOOL)copyFileAtPath:(NSString *)path toDirectory:(NSSearchPathDirectory)directory {
    BOOL success = NO;
    if ([self fileExistsAtPath:path]) {
        NSString *directoryPath = [self pathToDirectory:directory];
        NSError *error = nil;
        success = [self copyItemAtPath:path toPath: directoryPath error:&error];
        if (!success) {
            NSLog(@"[ERROR] %@ from (%@) to (%@)", error, path, directoryPath);
        }
    }
    
    return success;
}

- (NSString *)pathToPlistInDocumentDirectory {
    NSString *filePath = [self pathToFile:kANSPlist inDirectory:NSDocumentDirectory];
    if (![self fileExistsAtPath: filePath]) {
        NSString *plistFromBundle =[[NSBundle mainBundle] pathForResource:@"data" ofType:@"plist"];
        BOOL success = [self copyFileAtPath:plistFromBundle toDirectory:NSDocumentDirectory];
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
