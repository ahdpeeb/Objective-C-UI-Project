//
//  ANSFBLoginContext.h
//  Objective-C UI Project
//
//  Created by Nikola Andriiev on 25.09.16.
//  Copyright © 2016 Andriiev.Mykola. All rights reserved.
//

#import "ANSFBContext.h"

@class ANSLoginViewController;

@interface ANSFBLoginContext : ANSFBContext
@property (nonatomic, weak, readonly) ANSLoginViewController *viewController;

- (instancetype)initWithModel:(id)model controller:(ANSLoginViewController *)controller;

@end
