//
//  ANSOneIndexHelper.h
//  Objective-C UI Project
//
//  Created by Nikola Andriiev on 12.08.16.
//  Copyright © 2016 Andriiev.Mykola. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "ANSChangeModel.h"

@interface ANSOneIndexModel : ANSChangeModel

//You should never call setter to this ptoperty.
//write mod intended for subclasses
@property (nonatomic, assign) NSUInteger index;

- (instancetype)initWithIndex:(NSUInteger)index;

@end
