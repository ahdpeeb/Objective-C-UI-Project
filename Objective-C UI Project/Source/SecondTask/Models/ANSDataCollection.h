//
//  ANSDataCollection.h
//  Objective-C UI Project
//
//  Created by Nikola Andriiev on 24.07.16.
//  Copyright © 2016 Andriiev.Mykola. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ANSDataCollection : NSObject
@property (nonatomic, readonly) NSUInteger count;
@property (nonatomic, readonly) NSArray *obsject;

- (instancetype)initWithObjects:(NSArray *)objects;

- (id)dataAtIndex:(NSUInteger)index; 
- (NSUInteger)indexOfData:(id)data;
- (void)moveDataFromIndex:(NSUInteger)fromIndex toIndex:(NSUInteger)toIndex;

// dot'n call this method directly
- (id)objectAtIndexedSubscript:(NSUInteger)idx; 

@end
