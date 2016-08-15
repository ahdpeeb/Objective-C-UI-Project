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
@property (nonatomic, assign) NSUInteger index2;

- (instancetype)initWithIndex:(NSUInteger)index
                       index2:(NSUInteger)index2;

@end
