//
//  ANSCollectionHelper.h
//  Objective-C UI Project
//
//  Created by Nikola Andriiev on 12.08.16.
//  Copyright © 2016 Andriiev.Mykola. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ANSCollectionHelper : NSObject

typedef NS_ENUM(NSUInteger, ANSHelperState) {
    ANSAddData,
    ANSRemoveData,
    ANSMoveData,
};

@property (nonatomic, assign) ANSHelperState *state;

+ (instancetype)helperWithState:(ANSHelperState)state;

@end
