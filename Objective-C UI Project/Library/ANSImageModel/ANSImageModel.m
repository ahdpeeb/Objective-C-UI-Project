//
//  ANSImageModel.m
//  Objective-C UI Project
//
//  Created by Nikola Andriiev on 29.07.16.
//  Copyright © 2016 Andriiev.Mykola. All rights reserved.
//

#import "ANSImageModel.h"

#import "ANSImageModelDispatcher.h"

#import "ANSMacros.h"

@interface ANSImageModel ()
@property (nonatomic, strong)      UIImage          *image;
@property (nonatomic, strong)      NSURL            *url;
@property (nonatomic, strong)      NSOperation      *operation;

@property (nonatomic, assign, getter=isLoaded) BOOL loaded;

- (NSOperation *)imageLoadingOperation;

@end

@implementation ANSImageModel

#pragma mark -
#pragma mark Class methods

+ (instancetype)imageFromURL:(NSURL *)url {
    return [[self alloc] initWithURL:url];
}

#pragma mark -
#pragma mark Initialization and deallocation

- (void)dealloc {
    self.operation = nil;
}

- (instancetype)initWithURL:(NSURL *)url {
    self = [super init];
    if (self) {
        self.url = url;
    }
    
    return self;
}

#pragma mark -
#pragma mark Accessors

- (void)setOperation:(NSOperation *)operation {
    if (_operation != operation) {
        [operation cancel];
        
        _operation = operation;
        
        if (operation) {
            ANSImageModelDispatcher *dispatcher = [ANSImageModelDispatcher new];
            [[dispatcher queue] addOperation:operation];
        }

    }
}

#pragma mark -
#pragma mark Public Methods

- (void)load {
    @synchronized(self) {
        if (self.state == ANSImageModelLoading) {
            return;
        }
        
        if (self.state == ANSImageModelLoaded) {
            [self notifyOfStateChange:ANSImageModelLoaded];
        }
        
        self.state =ANSImageModelLoading;
    }
    
    self.operation = [self imageLoadingOperation];
}

- (void)dump {
    self.operation = nil;
    self.image = nil;
    self.state = ANSImageModelUnloaded;
}

#pragma mark -
#pragma mark Private methods

- (NSOperation *)imageLoadingOperation {
    ANSWeakify(self);

  //  __weak ANSImageModel *weakSelf = self;
    NSBlockOperation *operation = [NSBlockOperation blockOperationWithBlock:^{
        ANSStrongify(self);
     //   __strong ANSImageModel *strongSelf = weakSelf;
        
        self.image = [UIImage imageWithContentsOfFile:[self.url absoluteString]];
    }];
    
    operation.completionBlock = ^{
        ANSStrongify(self);
        self.state = self.image ? ANSImageModelLoaded : ANSImageModelFailedLoadin;
    };
    
    return operation;
}

@end
