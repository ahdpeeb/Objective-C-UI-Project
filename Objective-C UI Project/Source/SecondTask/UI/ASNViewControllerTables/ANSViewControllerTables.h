//
//  ANSViewControllerTables.h
//  Objective-C UI Project
//
//  Created by Nikola Andriiev on 22.07.16.
//  Copyright © 2016 Andriiev.Mykola. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ANSUsersModel.h"

@interface ANSViewControllerTables : UIViewController <
    UITableViewDataSource,
    UITableViewDelegate,
    UISearchBarDelegate,
    ANSCollectionObserverSpecial
>

@property (nonatomic, strong) ANSUsersModel *collection;
@property (nonatomic, strong) IBOutlet UISwipeGestureRecognizer *rightSwipeGesture;

- (IBAction)OnRightSwipe:(UISwipeGestureRecognizer *)sender; 

@end
