//
//  ANSOneIndexModel+UItableView.m
//  Objective-C UI Project
//
//  Created by Nikola Andriiev on 16.08.16.
//  Copyright © 2016 Andriiev.Mykola. All rights reserved.
//

#import "ANSOneIndexModel+UITableView.h"

#import <UIKit/UIKit.h>

@implementation ANSOneIndexModel (UTtableView)

- (void)applyToTableView:(UITableView *)tableView {
    NSIndexPath *path = [NSIndexPath indexPathForRow:self.index inSection:0];
    
    [tableView beginUpdates];
    
    switch (self.state) {
        case ANSStateAddObject:
            [tableView insertRowsAtIndexPaths:@[path] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case ANSStateRemoveObject:
            [tableView deleteRowsAtIndexPaths:@[path] withRowAnimation:UITableViewRowAnimationMiddle];
            break;
            
        default:
            [tableView reloadData];
            break;
    }
    
    [tableView endUpdates];
}

@end
