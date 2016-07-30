//
//  ANSImageModelDispatcher.h
//  Objective-C UI Project
//
//  Created by Nikola Andriiev on 29.07.16.
//  Copyright © 2016 Andriiev.Mykola. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ANSImageModelDispatcher : NSObject
@property (nonatomic, readonly) NSOperationQueue *queue; 

+ (instancetype)sharedDispatcher; 

@end
