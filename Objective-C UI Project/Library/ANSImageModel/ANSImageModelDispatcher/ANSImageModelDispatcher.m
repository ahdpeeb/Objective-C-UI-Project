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
        dispatcher = [[self alloc] init];
    });
    
    return dispatcher;
}

#pragma mark -
#pragma mark Initialization and deallocation

//static id dispatcher = nil;
//
//+ (instancetype)allocWithZone:(struct _NSZone *)zone {
//    static dispatch_once_t onceToken;
//    dispatch_once(&onceToken, ^{
//        dispatcher = [self allocWithZone:zone];
//    });
//    
//    return dispatcher;
//}

- (instancetype)init {
    self = [super init];
    if (self) {
        [self initQueue];
    }
    
    return self;
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
