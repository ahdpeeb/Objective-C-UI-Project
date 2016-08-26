//
//  NSFileManager+ANSExtension.h
//  Objective-C UI Project
//
//  Created by Nikola Andriiev on 24.08.16.
//  Copyright © 2016 Andriiev.Mykola. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSFileManager (ANSExtension)

- (NSString *)pathToSearchPathDirectory:(NSSearchPathDirectory)directory;
- (NSString *)pathToDocumentDirectory;
- (NSString *)pathToApplicationDirectory;

// argument file format should be write with extension.Sample - "data.txt"
- (NSString *)pathToFile:(NSString *)file inSearchPathDirectory:(NSSearchPathDirectory)directory;

// argument file format should be write with extension.Sample - "data.txt"
- (BOOL)fileExists:(NSString *)file inSearchPathDirectory:(NSSearchPathDirectory)directory;

- (NSString *)directoryWithName:(NSString *)name inSearchPathDirectory:(NSSearchPathDirectory)directory;

// argument file format should be write with extension.Sample - "data.txt"
- (void)removeFile:(NSString *)file fromSearchPathDirectory:(NSSearchPathDirectory)directory;

- (BOOL)copyFileAtPath:(NSString *)filePath toSearchPathDirectory:(NSSearchPathDirectory)directory;

// generate path to "file.plist" file. You shoud write file name to "file" argument;
- (NSString *)pathToPlistFile:(NSString *)file
        inSearchPathDirectory:(NSSearchPathDirectory)directory;

// returns string array fileNames(with extension) at path
- (NSArray <NSString *> *)filesNamesAtPath:(NSString *)path;

@end
