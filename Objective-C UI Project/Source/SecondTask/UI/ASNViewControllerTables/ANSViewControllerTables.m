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

- (void)setCollection:(ANSDataCollection *)collection {
    if (_collection != collection) {
        [_collection removeObserverObject:self];
        _collection = collection;
        [_collection addObserverObject:self];
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
    [sender setTitle:(isEditing) ? @"Edit" : @"Done" forState:UIControlStateNormal];
    [table setEditing:(isEditing) ? NO : YES animated:YES];
}

- (IBAction)addButton:(id)sender {
    ANSData *object = [ANSData new];
    [self.collection insertData:object atIndex:0];
}

#pragma mark -
#pragma mark UITableViewDataSource protocol

- (nullable NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if (!section) {
        return [NSString stringWithFormat:@"Homer's contact list"];
    }
    
    return nil;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSUInteger value = self.collection.count;
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
    
    ANSData *object = self.collection[indexPath.row];
    
    cell.label.text =   object.string;
    cell.imageView.image = object.image;

    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
    // replace rows 
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath {
    if (sourceIndexPath.section == destinationIndexPath.section) {
        [self.collection moveDataFromIndex:sourceIndexPath.row toIndex:destinationIndexPath.row];
    }
}
    //delate row (related with protocol methods editingStyleForRowAtIndexPath/ shouldIndentWhileEditingRowAtIndexPath)
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        NSUInteger index = indexPath.row;
        [self.collection removeDataAtIndex:index];
    }
}

#pragma mark -
#pragma mark UITableViewDelegate protocol

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewCellEditingStyleDelete;
}
    //should shift if (aditing = YES)
- (BOOL)tableView:(UITableView *)tableView shouldIndentWhileEditingRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

#pragma mark -
#pragma mark ANSCollectionObserver protocol

- (void)collection:(ANSDataCollection *)collection didAddData:(id)data {
    UITableView *table = self.tableView.table;
    NSUInteger index = [collection indexOfData:data];
    
    [table beginUpdates];
    NSIndexPath *path = [NSIndexPath indexPathForRow:index inSection:0];
    [table insertRowsAtIndexPaths:@[path] withRowAnimation:UITableViewRowAnimationRight];
    [table endUpdates];
    
    NSLog(@"collectionDidAddedData, - %lu ", collection.count);
}

- (void)collection:(ANSDataCollection *)collection didRemoveData:(id)data {
    UITableView *table = self.tableView.table;
    NSUInteger index = [collection indexOfData:data];
    
    [table beginUpdates];
    NSIndexPath *path = [NSIndexPath indexPathForRow:0 inSection:0];
    [table deleteRowsAtIndexPaths:@[path] withRowAnimation:UITableViewRowAnimationLeft];
    [table endUpdates];

    NSLog(@"collectionDidRemovedData, - %lu ", collection.count);
}

- (void)collectionDidMoveData:(ANSDataCollection *)collection {
    [self.tableView.table reloadData];
    NSLog(@"collectionDidMovedData, - %lu ", collection.count);
}

- (void)collectionDidInit:(ANSDataCollection *)collection {
    UITableView *table = self.tableView.table;
    [table reloadData];
}

@end
