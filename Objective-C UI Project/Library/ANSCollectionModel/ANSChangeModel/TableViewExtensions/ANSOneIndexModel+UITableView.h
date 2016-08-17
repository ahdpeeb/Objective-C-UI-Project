//
//  ANSOneIndexModel+UItableView.h
//  Objective-C UI Project
//
//  Created by Nikola Andriiev on 16.08.16.
//  Copyright © 2016 Andriiev.Mykola. All rights reserved.
//

#import "ANSOneIndexModel.h"

#import <UIKit/UIKit.h>

@interface ANSOneIndexModel (UITableView)

- (void)applyToTableView:(UITableView *)tableView;

- (void)applyToTableView:(UITableView *)tableView
            rowAnimation:(UITableViewRowAnimation)animation;

@end
