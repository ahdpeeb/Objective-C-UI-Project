//
//  ANSTablesView.m
//  Objective-C UI Project
//
//  Created by Nikola Andriiev on 22.07.16.
//  Copyright © 2016 Andriiev.Mykola. All rights reserved.
//

#import "ANSTableView.h"

@interface ANSTableView ()
//vertical indent for table and scrollIndicator
- (void)hsPace:(CGFloat)top;

@end

@implementation ANSTableView

#pragma mark -
#pragma mark Initialization and dealloc 

- (void)awakeFromNib {
    [super awakeFromNib];
    
    [self hsPace:0];
}

#pragma mark -
#pragma mark Private

- (void)hsPace:(CGFloat)top {
    //table and scrol indicator should not cover statusBar
    UIEdgeInsets insect = UIEdgeInsetsMake(top, 0, 0, 0);
    UITableView *table = self.table;
    table.contentInset = insect;
    table.scrollIndicatorInsets = insect;
}


@end
