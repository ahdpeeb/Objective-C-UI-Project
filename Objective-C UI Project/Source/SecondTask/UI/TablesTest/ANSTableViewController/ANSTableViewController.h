//
//  ANSTableViewController.h
//  Objective-C UI Project
//
//  Created by Nikola Andriiev on 21.07.16.
//  Copyright © 2016 Andriiev.Mykola. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ANSTableView.h"
#import "ANSUser.h"

@interface ANSTableViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong)       ANSUser         *userObject;

@end
