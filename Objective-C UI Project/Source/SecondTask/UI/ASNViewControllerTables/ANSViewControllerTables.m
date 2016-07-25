//
//  ANSViewControllerTables.m
//  Objective-C UI Project
//
//  Created by Nikola Andriiev on 22.07.16.
//  Copyright © 2016 Andriiev.Mykola. All rights reserved.
//

#import "ANSViewControllerTables.h"

#import "ANSTableView.h"
#import "ANSDataCell.h"
#import "ANSTableViewCell.h"
#import "ANSData.h"

#import "ANSMacros.h"
#import "NSArray+ANSExtension.h"

@interface ANSViewControllerTables ()
ANSViewPropertySynthesize(ANSTableView, tableView)

@end

@implementation ANSViewControllerTables;
@dynamic tableView;

#pragma mark -
#pragma mark Accsessors

- (void)setData:(ANSDataCollection *)data {
    if (_data != data) {
        data = data;
        
        [self.tableView.table reloadData];
    }
}

ANSViewGetterSynthesize(ANSTableView, tableView)

#pragma mark -
#pragma mark View life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
        
    self.tableView.table.editing = YES; // need to make switcher;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

#pragma mark -
#pragma mark UITableViewDataSource protocol

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    NSUInteger value = self.data.count;
    return value;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *identifire = NSStringFromClass([ANSDataCell class]);
    
    ANSDataCell *cell = [tableView dequeueReusableCellWithIdentifier:identifire];
    if (!cell) {
        UINib *nib = [UINib nibWithNibName:identifire bundle:nil];
        NSArray *cells = [nib instantiateWithOwner:nil options:nil];
        cell = [cells firstObject];
    }
    
    ANSData *object = self.data[indexPath.row];
    cell.label.text = object.string;
    
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath {
    if (sourceIndexPath.section == destinationIndexPath.section) {
        [self.data moveDataFromIndex:sourceIndexPath.row toIndex:destinationIndexPath.row];
    }
}


@end
