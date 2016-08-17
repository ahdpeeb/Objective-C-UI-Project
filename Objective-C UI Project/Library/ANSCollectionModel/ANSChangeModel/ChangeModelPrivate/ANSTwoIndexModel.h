//
//  ANSTwoIndexHepler.h
//  Objective-C UI Project
//
//  Created by Nikola Andriiev on 12.08.16.
//  Copyright © 2016 Andriiev.Mykola. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "ANSOneIndexModel.h"

@interface ANSTwoIndexModel : ANSOneIndexModel
@property (nonatomic, readonly) NSUInteger indexTwo;

- (instancetype)initWithIndex:(NSUInteger)index
                     indexTwo:(NSUInteger)indexTwo;

@end
