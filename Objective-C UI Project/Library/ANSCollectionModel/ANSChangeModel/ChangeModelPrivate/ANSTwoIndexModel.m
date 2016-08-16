//
//  ANSTwoIndexHepler.m
//  Objective-C UI Project
//
//  Created by Nikola Andriiev on 12.08.16.
//  Copyright © 2016 Andriiev.Mykola. All rights reserved.
//

#import "ANSTwoIndexModel.h"

@implementation ANSTwoIndexModel

- (instancetype)initWithIndex:(NSUInteger)index
                     indexTwo:(NSUInteger)indexTwo
{
    self = [super initWithIndex:index];
    self.indexTwo = indexTwo;
    
    return self;
}

@end
