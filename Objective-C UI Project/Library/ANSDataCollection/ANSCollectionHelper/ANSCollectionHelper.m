//
//  ANSCollectionHelper.m
//  Objective-C UI Project
//
//  Created by Nikola Andriiev on 12.08.16.
//  Copyright © 2016 Andriiev.Mykola. All rights reserved.
//

#import "ANSCollectionHelper.h"
#import "ANSOneIndexHelper.h"
#import "ANSTwoIndexHepler.h"

@implementation ANSCollectionHelper

#pragma mark -
#pragma mark Class methods

+ (instancetype)helperWithState:(ANSHelperState)state {
    if (state == ANSAddData || state == ANSRemoveData) {
        return [ANSOneIndexHelper new];
    }  else {
        return [ANSTwoIndexHepler new];
    }
}

- (instancetype)init {
    if ([self class] == [ANSCollectionHelper class]) {
        [NSException raise:@"Invalid identifier" format:@"You should never call init method for ANSCollectionHelper"];
    }
    
    self = [super init];
    return self;
}

@end
