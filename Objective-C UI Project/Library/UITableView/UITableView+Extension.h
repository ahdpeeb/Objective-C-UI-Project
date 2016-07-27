//
//  UITableView+Extension.h
//  Objective-C UI Project
//
//  Created by Nikola Andriiev on 27.07.16.
//  Copyright © 2016 Andriiev.Mykola. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITableView (Extension)
// cls should be heir of ANSTableViewCell
- (id)reusableCellfromNibWithClass:(Class)cls;

@end
