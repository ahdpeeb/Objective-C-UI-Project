//
//  ANSViewControllerTables.h
//  Objective-C UI Project
//
//  Created by Nikola Andriiev on 22.07.16.
//  Copyright © 2016 Andriiev.Mykola. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ANSUsersModel.h"
#import "ANSNameFilterModel.h"

@interface ANSViewControllerTables : UIViewController <
    UITableViewDataSource,
    UITableViewDelegate,
    UISearchBarDelegate,

    ANSUsersModelObserver,
    ANSNameFilterModelProtocol
>

@property (nonatomic, strong) ANSUsersModel *users;
@property (nonatomic, strong) ANSNameFilterModel *filteredModel;

@property (nonatomic, strong) IBOutlet UISwipeGestureRecognizer *rightSwipeGesture;

- (IBAction)onRightSwipe:(UISwipeGestureRecognizer *)sender;

@end
