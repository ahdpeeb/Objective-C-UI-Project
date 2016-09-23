//
//  ANSContextModel.m
//  Objective-C UI Project
//
//  Created by Nikola Andriiev on 23.09.16.
//  Copyright © 2016 Andriiev.Mykola. All rights reserved.
//

#import "ANSContextModel.h"

#import "ANSGCD.h"
#import "ANSMacros.h"

@interface ANSContextModel ()
@property (nonatomic, strong) id model;

@end

@implementation ANSContextModel

- (instancetype)initWitModel:(id)model {
    self = [super init];
    if (self) {
        self.model = model;
    }
    
    return self;
}

#pragma mark -
#pragma mark Private methods

- (SEL)selectorForState:(NSUInteger)state {
    switch (state) {
        case ANSContextExecuting:
            return @selector(contextExecuting:);
            
        case ANSContextDidFinishExecution:
            return @selector(contextDidFinishExecution:);
            
        case ANSContextDidFailedExecution:
            return @selector(contextDidFailedExecution:);
            
        default:
            return [super selectorForState:state];
    }
}

- (void)performProcessing {
    [self doesNotRecognizeSelector:_cmd];
}

#pragma mark -
#pragma mark Public methods

- (void)execute {
    @synchronized(self) {
        ANSContextState state = self.state;
        if (state == ANSContextExecuting) {
            [self notifyOfStateChange:state];
            
            return;
        }
        
        if (state == ANSContextDidFinishExecution || state == ANSContextDidFailedExecution) {
            self.state = ANSContextExecuting;
            
            ANSWeakify(self);
            ANSPerformInAsyncQueue(ANSPriorityDefault, ^{
                ANSStrongify(self);
                [self performProcessing];
            });

        }
            
    }
}

- (void)cancel {

}

@end
