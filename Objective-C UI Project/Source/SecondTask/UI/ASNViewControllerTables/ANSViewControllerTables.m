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
#import "ANSBuffer.h"

#import "ANSMacros.h"
#import "NSArray+ANSExtension.h"
#import "UINib+Extension.h"

static NSString * const kANSEdit = @"Edit";
static NSString * const kANSDone = @"Done";

ANSViewControllerBaseViewProperty(ANSViewControllerTables, ANSTableView, tableView)

@implementation ANSViewControllerTables;

#pragma mark -
#pragma mark Accsessors

- (void)setCollection:(ANSDataCollection *)collection {
    if (_collection != collection) {
        [_collection removeObserverObject:self];
        _collection = collection;
        [_collection addObserverObject:self];
    }
}

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
    BOOL isEditing = self.tableView.table.editing;
    [sender setTitle:(isEditing ? kANSEdit : kANSDone) forState:UIControlStateNormal];
    [table setEditing:(isEditing ? NO : YES) animated:YES];
}

- (IBAction)addButton:(id)sender {
    if (self.tableView.table.editing) {
        ANSData *object = [ANSData new];
        [self.collection insertData:object atIndex:0];
    }
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
    return self.collection.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *identifire = NSStringFromClass([ANSDataCell class]);
    
    ANSDataCell *cell = [tableView dequeueReusableCellWithIdentifier:identifire];
    if (!cell) {
        UINib *nib = [UINib nibWithName:[ANSDataCell class]];
        cell = [nib elementFromNibWithClass:[ANSDataCell class]];
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

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
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
    //should shift leftBar if (aditing = YES)
- (BOOL)tableView:(UITableView *)tableView shouldIndentWhileEditingRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

#pragma mark -
#pragma mark ANSCollectionObserver protocol

- (void)collection:(ANSDataCollection *)collection didUpdateData:(id)data {
    ANSBuffer *buffer = data;
    UITableView *table = self.tableView.table;
    
    NSIndexPath *path = [NSIndexPath indexPathForRow:buffer.value inSection:0];
    
    [table beginUpdates];
    [table performSelector:buffer.selector withObject:@[path]];
    [table endUpdates];
    
    NSLog(@"collectionDidUpdate, - %lu ", collection.count);
}

@end
