//
//  ANSViewControllerTables.h
//  Objective-C UI Project
//
//  Created by Nikola Andriiev on 22.07.16.
//  Copyright © 2016 Andriiev.Mykola. All rights reserved.
//

#import <CoreData/CoreData.h>
#import <UIKit/UIKit.h>

@class ANSUser;

@interface ANSFriendListViewController : UIViewController <
    UITableViewDataSource,
    UITableViewDelegate,
    UISearchBarDelegate,
    UINavigationControllerDelegate,
    NSFetchedResultsControllerDelegate

//    ANSArrayModelObserver,
//    ANSNameFilterModelProtocol
>

@property (nonatomic, strong) ANSUser *user;

@property (nonatomic, strong) IBOutlet UISwipeGestureRecognizer *rightSwipeGesture;

- (IBAction)onRightSwipe:(UISwipeGestureRecognizer *)sender;

@end
