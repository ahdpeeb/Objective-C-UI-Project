//
//  UITableView+Extension.h
//  Objective-C UI Project
//
//  Created by Nikola Andriiev on 27.07.16.
//  Copyright © 2016 Andriiev.Mykola. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ANSAnimationBlock)(void);

@interface UITableView (Extension)
// cls should be child class of ANSTableViewCell class
- (id)reusableCellfromNibWithClass:(Class)cls;


- (void)performAnimationBlock:(ANSAnimationBlock)block;

@end
