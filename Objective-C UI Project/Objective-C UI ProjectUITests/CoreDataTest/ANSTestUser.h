//
//  ANSTestUSer.h
//  Objective-C UI Project
//
//  Created by Nikola Andriiev on 06.10.16.
//  Copyright © 2016 Andriiev.Mykola. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ANSTestUser : NSObject
@property (nonatomic, strong) NSString *firsName;
@property (nonatomic, strong) NSString *secondName;
@property (nonatomic, assign) NSUInteger age;

+ (instancetype)randomUser;

@end
