//
//  NSFileManager+ANSExtension.h
//  Objective-C UI Project
//
//  Created by Nikola Andriiev on 24.08.16.
//  Copyright © 2016 Andriiev.Mykola. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSFileManager (ANSExtension)

- (NSString *)pathToDocumentDirectory; 
- (NSString *)pathToApplicationDirectory;
- (NSString *)pathToDirectory:(NSSearchPathDirectory)directory;

// argument file format should be write with extension.Sample - "data.plist"
- (NSString *)pathToFile:(NSString *)file inDirectory:(NSSearchPathDirectory)directory;

// argument file format should be write with extension.Sample - "data.plist"
- (BOOL)isExistsFile:(NSString *)file inDirectory:(NSSearchPathDirectory)directory;

- (NSString *)directoryWithName:(NSString *)name inDirectory:(NSSearchPathDirectory)directory;

// argument file format should be write with extension.Sample - "data.plist"
- (void)removeFile:(NSString *)file fromDirectory:(NSSearchPathDirectory)directory;

- (BOOL)copyFileAtPath:(NSString *)path toDirectory:(NSSearchPathDirectory)directory;

- (NSString *)pathToPlistInDocumentDirectory; 

// returns string array fileNames(with extension) at path
- (NSArray <NSString *> *)fileNamesAtPath:(NSString *)path;

@end
