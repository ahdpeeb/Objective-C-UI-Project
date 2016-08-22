//
//  UITableView+Extension.m
//  Objective-C UI Project
//
//  Created by Nikola Andriiev on 27.07.16.
//  Copyright © 2016 Andriiev.Mykola. All rights reserved.
//

#import "UITableView+Extension.h"

#import "UINib+Extension.h"
#import "ANSTableViewCell.h"

@implementation UITableView (Extension)

- (id)reusableCellfromNibWithClass:(Class)cls {
    NSString *identifire = NSStringFromClass(cls);
    ANSTableViewCell *cell = [self dequeueReusableCellWithIdentifier:identifire];
    if (!cell) {
        UINib *nib = [UINib nibWithClass:cls];
        cell = [nib objectWithClass:[cls class]];
        
        return cell;
    }
    
    return nil;
}

- (void)performAnimationBlock:(ANSAnimationBlock)block {
    if (!block) {
        return;
    }
    
    [self beginUpdates];
    block();
    [self endUpdates];
}

@end
