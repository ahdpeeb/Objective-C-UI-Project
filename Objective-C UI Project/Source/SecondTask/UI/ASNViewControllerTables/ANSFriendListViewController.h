//
//  ANSViewControllerTables.h
//  Objective-C UI Project
//
//  Created by Nikola Andriiev on 22.07.16.
//  Copyright © 2016 Andriiev.Mykola. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ANSFaceBookFriends.h"
#import "ANSNameFilterModel.h"

@interface ANSFriendListViewController : UIViewController <
    UITableViewDataSource,
    UITableViewDelegate,
    UISearchBarDelegate,

    ANSArrayModelObserver,
    ANSNameFilterModelProtocol
>

@property (nonatomic, strong) ANSFaceBookFriends *friends;

@property (nonatomic, strong) IBOutlet UISwipeGestureRecognizer *rightSwipeGesture;

- (IBAction)onRightSwipe:(UISwipeGestureRecognizer *)sender;

@end
