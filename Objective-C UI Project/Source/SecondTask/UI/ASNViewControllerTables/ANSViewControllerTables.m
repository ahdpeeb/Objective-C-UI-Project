//
//  ANSViewControllerTables.m
//  Objective-C UI Project
//
//  Created by Nikola Andriiev on 22.07.16.
//  Copyright © 2016 Andriiev.Mykola. All rights reserved.
//

#import "ANSViewControllerTables.h"

#import "ANSTableView.h"

@interface ANSViewControllerTables ()
ANSViewPropertySynthesize(ANSTableView, tableView)

@end

@implementation ANSViewControllerTables;
@dynamic tableView;

#pragma mark -
#pragma mark Accsessors

ANSViewGetterSynthesize(ANSTableView, tableView)

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
