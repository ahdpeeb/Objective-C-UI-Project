//
//  ANSImageModelDispatcher.m
//  Objective-C UI Project
//
//  Created by Nikola Andriiev on 29.07.16.
//  Copyright © 2016 Andriiev.Mykola. All rights reserved.
//

#import "ANSImageModelDispatcher.h"

@interface ANSImageModelDispatcher ()
@property (nonatomic, strong) NSOperationQueue *queue;

- (void)initQueue;

@end

@implementation ANSImageModelDispatcher

#pragma mark -
#pragma mark Class methods

+ (instancetype)sharedDispatcher {
    static id dispatcher = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        dispatcher = [self new];
    });
    
    return dispatcher;
}

#pragma mark -
#pragma mark Initialization and deallocation

- (void)dealloc {
    self.queue = nil;
}

static id dispatcher = nil;

+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        dispatcher = [self allocWithZone:zone];
    });
    
    return dispatcher;
}

- (instancetype)init {
    __block id object = self;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        object = [super init];
        if (object) {
            [object initQueue];
        }
    });
    
    return object;
}

- (void)initQueue {
    NSOperationQueue *queue = [NSOperationQueue new];
    queue.maxConcurrentOperationCount = 2;
    
    self.queue = queue;
}

#pragma mark -
#pragma mark Accsessors

- (void)setQueue:(NSOperationQueue *)queue {
    if (_queue != queue) {
        [_queue cancelAllOperations];
        
        _queue = queue;
    }
}

@end