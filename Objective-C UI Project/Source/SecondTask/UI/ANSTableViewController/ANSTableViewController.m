//
//  ANSTableViewController.m
//  Objective-C UI Project
//
//  Created by Nikola Andriiev on 21.07.16.
//  Copyright © 2016 Andriiev.Mykola. All rights reserved.
//

#import "ANSTableViewController.h"

#import "ANSTableView.h"

#import "ANSMacros.h"

@interface ANSTableViewController ()

@end

@implementation ANSTableViewController

@dynamic tableView;

#pragma mark -
#pragma mark Accsessors

ANSViewGetterSynthesize(ANSTableView, tableView)

#pragma mark -
#pragma mark View LifeCycle

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView.table reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -
#pragma mark UITableViewDataSource protocol
    //section is a group of cells
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString * const kANSCellName = @"kANSCellName";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kANSCellName];
    if (cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kANSCellName];
    }
    
     cell.textLabel.text = @"HELLO";
    
    return cell;
}

@end
