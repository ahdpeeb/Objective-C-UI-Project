//
//  ANSViewControllerTables.h
//  Objective-C UI Project
//
//  Created by Nikola Andriiev on 22.07.16.
//  Copyright © 2016 Andriiev.Mykola. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ANSUsersCollection.h"

@interface ANSViewControllerTables : UIViewController <
    UITableViewDataSource,
    UITableViewDelegate,
    UISearchBarDelegate,
    ANSCollectionObserver
>

@property (nonatomic, strong) ANSUsersCollection *collection;

@end
