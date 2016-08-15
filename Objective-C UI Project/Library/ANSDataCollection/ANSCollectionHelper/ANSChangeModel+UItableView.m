//
//  ANSChangeModel+UItableView.m
//  Objective-C UI Project
//
//  Created by Nikola Andriiev on 15.08.16.
//  Copyright © 2016 Andriiev.Mykola. All rights reserved.
//
#import <UIKit/UIKit.h>

#import "ANSChangeModel+UItableView.h"

#import "ANSOneIndexModel.h"
#import "ANSTwoIndexModel.h"

@implementation ANSChangeModel (UItableView)

- (void)applyToTableView:(UITableView *)tableView {
    NSIndexPath *path = [NSIndexPath indexPathForRow:self.index inSection:0];
    
    NSIndexPath *path2 = nil;
    if ([self isMemberOfClass:[ANSTwoIndexModel class]]) {
        path2 = [NSIndexPath indexPathForRow:self.index2 inSection:0];
    }
    
    [tableView beginUpdates];
    
    switch (self.state) {
        case ANSStateAddData:
            [tableView insertRowsAtIndexPaths:@[path] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case ANSStateRemoveData:
            [tableView deleteRowsAtIndexPaths:@[path] withRowAnimation:UITableViewRowAnimationMiddle];
            break;
            
        case ANSStateMoveData:
            [tableView reloadRowsAtIndexPaths:@[path, path2] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case ANSStateExchangeData:
            [tableView reloadRowsAtIndexPaths:@[path, path2] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        default:
            [tableView reloadData]; 
            break;
    }
    
    [tableView endUpdates];
}

@end
