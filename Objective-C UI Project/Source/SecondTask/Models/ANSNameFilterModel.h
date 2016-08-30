//
//  ANSNameFilterModel.h
//  Objective-C UI Project
//
//  Created by Nikola Andriiev on 30.08.16.
//  Copyright © 2016 Andriiev.Mykola. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "ANSArrayModel.h"

@class ANSNameFilterModel;

@protocol ANSNameFilterModelProtocol <NSObject>

- (void)nameFilterModelDidFilter:(ANSNameFilterModel *)model;

@end



@interface ANSNameFilterModel : ANSArrayModel
@property (nonatomic, readonly) id observableObject;

- (instancetype)initWithObservableModel:(id <ANSArrayModelObserver>)model; 

- (void)sortCollectionByfilterStrirng:(NSString *)filterStrirng; 

@end
