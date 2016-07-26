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
        [_data removeObserverObject:self];
        _data = data;
        [_data addObserverObject:self];
    }
}

ANSViewGetterSynthesize(ANSTableView, tableView)

#pragma mark -
#pragma mark View life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

#pragma mark -
#pragma mark Actions

- (IBAction)editButton:(id)sender {
    UITableView *table = self.tableView.table;
    BOOL isEditing = table.editing;
    if (isEditing) {
        [table setEditing:NO animated:YES];
    } else {
        [table setEditing:YES animated:YES];
    }
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
    
    cell.label.text =   object.string;
    cell.imageView.image = object.image;

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

- (nullable NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if (!section) {
        return [NSString stringWithFormat:@"Homer's contact list"];
    }
    
    return nil;
}

#pragma mark -
#pragma mark UITableViewDelegate protocol

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewCellEditingStyleNone;
}
    //should shift if (aditing = YES)
- (BOOL)tableView:(UITableView *)tableView shouldIndentWhileEditingRowAtIndexPath:(NSIndexPath *)indexPath {
    return NO;
}

#pragma mark -
#pragma mark ANSCollectionObserver protocol

- (void)collectionDidAddedData:(ANSDataCollection *)collection {
    [self.tableView.table reloadData];
    NSLog(@"collectionDidAddedData, - %lu ", collection.count);
}
- (void)collectionDidRemovedData:(ANSDataCollection *)collection {
    [self.tableView.table reloadData];
    NSLog(@"collectionDidRemovedData, - %lu ", collection.count);
}
- (void)collectionDidMovedData:(ANSDataCollection *)collection {
    [self.tableView.table reloadData];
    NSLog(@"collectionDidMovedData, - %lu ", collection.count);
}

@end
