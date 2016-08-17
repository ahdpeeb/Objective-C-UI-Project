//
//  UIViewController+ANSExtension.m
//  Objective-C UI Project
//
//  Created by Nikola Andriiev on 17.08.16.
//  Copyright © 2016 Andriiev.Mykola. All rights reserved.
//

#import "UIViewController+ANSExtension.h"

@implementation UIViewController (ANSExtension)

+ (id)controller {
    UIViewController *object = [[self class] new];
    NSString *name = NSStringFromClass([object class]);

    return [object initWithNibName:name bundle:nil];
}

@end
