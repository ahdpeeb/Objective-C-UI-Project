//
//  ANSLoadimgModel.m
//  Objective-C UI Project
//
//  Created by Nikola Andriiev on 02.09.16.
//  Copyright © 2016 Andriiev.Mykola. All rights reserved.
//

#import "ANSLoadingModel.h"

#import "ANSGCD.h"

#import "ANSMacros.h"

@implementation ANSLoadingModel

#pragma mark -
#pragma mark Initilization and deallocation

- (instancetype)init {
    self = [super init];
    if (self) {
        [self performBlockWithoutNotification:^{
            self.state = ANSLoadingModelUnloaded;
        }];
        
    }
    return self;
}

#pragma mark -
#pragma mark Private methods

- (SEL)selectorForState:(NSUInteger)state {
    switch (state) {
        case ANSLoadingModelWillLoad:
            return @selector(loadingModelWillLoad:);
            
        case ANSLoadingModelLoading:
            return @selector(loadingModelLoading:);
            
        case ANSLoadingModelDidLoad:
            return @selector(loadingModelDidLoad:);
            
        case ANSLoadingModelDidFailLoading:
            return @selector(loadingModelDidFailLoading:);
            
        default:
            return [super selectorForState:state];
    }
}

#pragma mark -
#pragma mark Private methods

- (void)loadWithBlock:(ANSLoadingBlock)block {
    @synchronized(self) {
        ANSLoadingState state = self.state;
        if (state == ANSLoadingModelLoading || state == ANSLoadingModelDidLoad || state == ANSLoadingModelWillLoad) {
            [self notifyOfStateChange:state];
            return;
        }
        
        if (state == ANSLoadingModelUnloaded || state == ANSLoadingModelDidFailLoading) {
            self.state = ANSLoadingModelLoading;
            
            ANSWeakify(self);
            ANSPerformInAsyncQueue(ANSPriorityHigh, ^{
                ANSStrongify(self);
                
                BOOL isLoad = block();
                if (isLoad) {
                    self.state = ANSLoadingModelWillLoad;
                }
                
                self.state = (isLoad) ? ANSLoadingModelDidLoad : ANSLoadingModelDidFailLoading;
            });
        }
    }
}


@end
