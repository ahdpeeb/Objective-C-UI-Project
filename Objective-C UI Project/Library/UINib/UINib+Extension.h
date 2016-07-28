//
//  UINib+Extension.h
//  Objective-C UI Project
//
//  Created by Nikola Andriiev on 27.07.16.
//  Copyright © 2016 Andriiev.Mykola. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UINib (Extension)

+ (UINib *)nibWithClass:(Class)cls;

//this method returns root performance from nib with class.
// You are responsible for nib contains only one class as root performance
- (id)elementFromNibWithClass:(Class)cls; 

@end