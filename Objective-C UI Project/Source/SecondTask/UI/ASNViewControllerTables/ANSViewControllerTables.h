//
//  ANSViewControllerTables.h
//  Objective-C UI Project
//
//  Created by Nikola Andriiev on 22.07.16.
//  Copyright © 2016 Andriiev.Mykola. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ANSDataCollection.h"

@interface ANSViewControllerTables : UIViewController <UITableViewDataSource, UITableViewDataSource>

@property (nonatomic, strong) ANSDataCollection *data;

@end
