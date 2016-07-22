//
//  ANSTableViewController.m
//  Objective-C UI Project
//
//  Created by Nikola Andriiev on 21.07.16.
//  Copyright © 2016 Andriiev.Mykola. All rights reserved.
//

#import "ANSTableViewController.h"

#import "ANSTableView.h"
#import "ANSUserCell.h"

#import "ANSMacros.h"

@interface ANSTableViewController ()
@property (nonatomic, readonly)     ANSTableView    *tableView;

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
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString * identifier = NSStringFromClass([ANSUserCell class]);
    ANSUserCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell) {
      //  bundle:nil => from application folder
        UINib *nib = [UINib nibWithNibName:identifier bundle:nil];
        NSArray *cells = [nib instantiateWithOwner:nil options:nil];
        cell = [cells firstObject];
    }
    
    cell.userObject = self.userObject;
    
    return cell;
    //processing
}

@end
