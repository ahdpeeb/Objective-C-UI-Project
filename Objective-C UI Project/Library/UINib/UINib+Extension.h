//
//  UINib+Extension.h
//  Objective-C UI Project
//
//  Created by Nikola Andriiev on 27.07.16.
//  Copyright © 2016 Andriiev.Mykola. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UINib (Extension)

+ (UINib *)nibWithName:(Class)cls;

//it returns first root emelemt with class.
//only one root object with class from nib!
- (id)elementFromNibWithClass:(Class)cls; 

@end
