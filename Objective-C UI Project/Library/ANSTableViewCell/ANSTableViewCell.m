//
//  ANSTableViewSell.m
//  Objective-C UI Project
//
//  Created by Nikola Andriiev on 21.07.16.
//  Copyright © 2016 Andriiev.Mykola. All rights reserved.
//

#import "ANSTableViewCell.h"

@implementation ANSTableViewCell

#pragma mark -
#pragma mark Reloaded

- (NSString *)reuseIdentifier {
    return NSStringFromClass([self class]);
}

@end
