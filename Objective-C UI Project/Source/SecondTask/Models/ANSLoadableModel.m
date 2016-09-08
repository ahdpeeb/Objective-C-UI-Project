//
//  ANSLoadimgModel.m
//  Objective-C UI Project
//
//  Created by Nikola Andriiev on 02.09.16.
//  Copyright © 2016 Andriiev.Mykola. All rights reserved.
//

#import "ANSLoadableModel.h"

#import "ANSGCD.h"

#import "ANSMacros.h"

@implementation ANSLoadableModel

#pragma mark -
#pragma mark Initilization and deallocation

- (instancetype)init {
    self = [super init];
    if (self) {
        [self performBlockWithoutNotification:^{
            self.state = ANSLoadableModelUnloaded;
        }];
        
    }
    return self;
}

#pragma mark -
#pragma mark Private methods

- (SEL)selectorForState:(NSUInteger)state {
    switch (state) {
        case ANSLoadableModelLoading:
            return @selector(loadableModelLoading:);
            
        case ANSLoadableModelDidLoad:
            return @selector(loadableModelDidLoad:);
            
        case ANSLoadableModelDidFailLoading:
            return @selector(loadableModelDidFailLoading:);
            
        default:
            return [super selectorForState:state];
    }
}

#pragma mark -
#pragma mark Private methods

- (void)loadWithBlock:(ANSLoadingBlock)block {
    @synchronized(self) {
        if (!block) {
            return;
        }
        
        ANSLoadingState state = self.state;
        if (state == ANSLoadableModelLoading || state == ANSLoadableModelDidLoad) {
            [self notifyOfStateChange:state];
            return;
        }
        
        if (state == ANSLoadableModelUnloaded || state == ANSLoadableModelDidFailLoading) {
            self.state = ANSLoadableModelLoading;
            
            ANSWeakify(self);
            ANSPerformInAsyncQueue(ANSPriorityHigh, ^{
                ANSStrongify(self);
                
                BOOL isLoaded = block();
                
                self.state = (isLoaded) ? ANSLoadableModelDidLoad : ANSLoadableModelDidFailLoading;
            });
        }
    }
}


@end