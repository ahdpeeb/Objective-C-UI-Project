//
//  ANSFBLoginContext.h
//  Objective-C UI Project
//
//  Created by Nikola Andriiev on 25.09.16.
//  Copyright © 2016 Andriiev.Mykola. All rights reserved.
//

#import "ANSFBContext.h"

@class ANSLoginViewController;
@class ANSUser;

@interface ANSLoginContext : ANSFBContext
@property (nonatomic, weak, readonly) ANSLoginViewController *viewController;

- (instancetype)initWithModel:(ANSUser *)model
                   controller:(ANSLoginViewController *)controller;

@end
