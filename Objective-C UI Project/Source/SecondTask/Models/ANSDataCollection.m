//
//  ANSDataCollection.m
//  Objective-C UI Project
//
//  Created by Nikola Andriiev on 24.07.16.
//  Copyright © 2016 Andriiev.Mykola. All rights reserved.
//

#import "ANSDataCollection.h"

@interface ANSDataCollection ()
@property (nonatomic, retain) NSMutableArray *mutableData;

- (id)objectAtIndexedSubscript:(NSUInteger)idx;

@end

@implementation ANSDataCollection

@dynamic count;
@dynamic obsject;

#pragma mark -
#pragma mark Initialization and deallocation

- (instancetype)init {
    self = [super init];
    self.mutableData = [NSMutableArray new];
    
    return self;
}

- (instancetype)initWithObjects:(NSArray *)objects {
    self = [self init];
    self.mutableData = [NSMutableArray arrayWithArray:objects];
    
    return self;
}

#pragma mark -
#pragma mark Accsessors

- (NSUInteger)count {
    return self.mutableData.count;
}

- (NSArray *)obsject {
    return [self.mutableData copy];
}

#pragma mark -
#pragma mark Public methods; 

- (id)dataAtIndex:(NSUInteger)index {
    return [self.mutableData objectAtIndex:index];
}

- (NSUInteger)indexOfData:(id)data {
    return [self.mutableData indexOfObject:data];
}

- (void)moveDataFromIndex:(NSUInteger)fromIndex toIndex:(NSUInteger)toIndex {
    [self.mutableData exchangeObjectAtIndex:fromIndex withObjectAtIndex:toIndex];
}

#pragma mark -
#pragma mark Privat methods

- (id)objectAtIndexedSubscript:(NSUInteger)idx {
    return [self.mutableData objectAtIndex:idx];
}

@end
