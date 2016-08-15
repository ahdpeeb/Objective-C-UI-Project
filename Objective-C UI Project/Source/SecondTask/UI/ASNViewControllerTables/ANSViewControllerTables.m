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
#import "ANSUser.h"
#import "ANSDataInfo.h"
#import "ANSImageModel.h"
#import "ANSImageView.h"

#import "NSArray+ANSExtension.h"
#import "UINib+Extension.h"
#import "UITableView+Extension.h"
#import "ANSChangeModel.h"
#import "ANSChangeModel+UItableView.h"

#import "ANSMacros.h"
#import "ANSGCD.h"

static NSString * const kANSEdit                    = @"Edit";
static NSString * const kANSDone                    = @"Done";
static NSString * const kANSTitleForHeaderSection   = @"Homer's contact list";
static const NSUInteger kANSSectionsCount           = 1;

@interface ANSViewControllerTables ()
@property (nonatomic, strong) ANSProtocolObservationController  *controller;
@property (nonatomic, strong) ANSUsersCollection                *filteredCollection;

@property (nonatomic, strong) NSOperation                       *operation;
@property (nonatomic, strong) NSOperationQueue                  *operationsQueue;

- (void)sortCollectionInBackground:(ANSUsersCollection *)collection
                  withFilterString:(NSString *)filterStirng;

- (void)resignSearchBar;

@end

ANSViewControllerBaseViewProperty(ANSViewControllerTables, ANSTableView, tableView)

@implementation ANSViewControllerTables;

#pragma mark -
#pragma mark Accsessors

- (void)setOperation:(NSOperation *)operation {
    if (_operation != operation) {
        [_operation cancel];
        
        _operation = operation;
        
        NSOperationQueue *queue = self.operationsQueue;
        if (!queue) {
            self.operationsQueue = [NSOperationQueue new];
        }
        
        [queue addOperation:operation];
    }
}

- (void)setCollection:(ANSUsersCollection *)collection {
    if (_collection != collection) {
    //  [_collection removeObserverObject:self];
        _collection = collection;
        
        self.controller = [_collection protocolControllerWithObserver:self];
        
        [self.tableView.table reloadData];
    }
}

#pragma mark -
#pragma mark View lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = kANSTitleForHeaderSection;
    [self initLeftBarButtonItem];
    [self initRightBarButtonItem];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark -
#pragma mark Private methods
    //TableView Method
- (void)sortCollectionInBackground:(ANSUsersCollection *)collection
                    withFilterString:(NSString *)filterStirng
{
    ANSWeakify(self);
    self.operation = [NSBlockOperation blockOperationWithBlock:^{
        ANSStrongify(self);
      self.filteredCollection = [self.collection sortedCollectionWithString:filterStirng];
    }];

    self.operation.completionBlock = ^{
        ANSPerformInMainQueue(dispatch_async, ^{
            ANSStrongify(self);
            [self.tableView.table reloadData];
        });
    };
}

- (void)resignSearchBar {
    UISearchBar *searchBar = self.tableView.searchBar;
    if (searchBar.isFirstResponder) {
        [self searchBarCancelButtonClicked:searchBar];
    }
}

#pragma mark -
#pragma mark UIBarButtonItems
    //TableView Method
- (void)initLeftBarButtonItem {
    UIBarButtonItem *buttom = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(leftBarAction:)];
    [self.navigationItem setLeftBarButtonItem:buttom animated:YES];
}
    //TableView Method
- (void)initRightBarButtonItem {
    UIBarButtonItem *buttom = [[UIBarButtonItem alloc] initWithTitle:kANSEdit
                                                               style:UIBarButtonItemStyleDone
                                                              target:self
                                                              action:@selector(rightBarAction:)];
    
    [self.navigationItem setRightBarButtonItem:buttom animated:YES];
}

#pragma mark -
#pragma mark UIBarButtonItem actions

- (void)leftBarAction:(UIBarButtonItem *)sender {
    UITableView *table = self.tableView.table;
    
    [self resignSearchBar];
    
    if (table.editing) {
        ANSUser *object = [[ANSUser alloc] init];
        [self.collection insertData:object atIndex:0];
    }
}

- (void)rightBarAction:(UIBarButtonItem *)sender {
    UITableView *table = self.tableView.table;
    
    [self resignSearchBar];
    
    BOOL isEditing = table.editing;
    
    [sender setTitle:(isEditing ? kANSEdit : kANSDone)];
    [table setEditing:(isEditing ? NO : YES) animated:YES];
}

#pragma mark -
#pragma mark UITableViewDataSource protocol

- (nullable NSString *)tableView:(UITableView *)tableView
         titleForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return [NSString stringWithFormat:kANSTitleForHeaderSection];
    }
    
    return nil;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return kANSSectionsCount;
}

- (NSInteger)   tableView:(UITableView *)tableView
    numberOfRowsInSection:(NSInteger)section
{
    if (self.tableView.searchBar.isFirstResponder) {
        return self.filteredCollection.count;
    }  else {
        return self.collection.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ANSDataCell *cell = [tableView reusableCellfromNibWithClass:[ANSDataCell class]];
    
    ANSUser *object = nil;
    if (self.tableView.searchBar.isFirstResponder) {
        object = self.filteredCollection[indexPath.row];
    } else {
        object = self.collection[indexPath.row];
    }
    
    [cell fillInfoFromObject:object];

    return cell;
}

- (BOOL)        tableView:(UITableView *)tableView
    canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

- (void)    tableView:(UITableView *)tableView
   moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath
          toIndexPath:(NSIndexPath *)destinationIndexPath
{
    if (sourceIndexPath.section == destinationIndexPath.section) {
        [self.collection moveDataFromIndex:sourceIndexPath.row
                                   toIndex:destinationIndexPath.row];
    }
}

    //delate row (related with protocol methods editingStyleForRowAtIndexPath/ shouldIndentWhileEditingRowAtIndexPath)
- (void)    tableView:(UITableView *)tableView
    commitEditingStyle:(UITableViewCellEditingStyle)editingStyle
    forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [self.collection removeDataAtIndex:indexPath.row];
    }
}

#pragma mark -
#pragma mark UITableViewDelegate protocol

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView
           editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewCellEditingStyleDelete;
}
    //should shift leftBar if (aditing = YES)
- (BOOL)                        tableView:(UITableView *)tableView
   shouldIndentWhileEditingRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

#pragma mark -
#pragma mark UISearchBarDelegate protocol

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    [searchBar resignFirstResponder];
    [searchBar setShowsCancelButton:NO animated:YES];
    
    [self.tableView.table reloadData];
}

- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar {
    UITableView *table = self.tableView.table;
    if (table.isEditing) {
        return NO;
    }
    
    return YES;
}

- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar {
    [searchBar setShowsCancelButton:YES animated:YES];
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    [self sortCollectionInBackground:self.collection withFilterString:searchText];
}

#pragma mark -
#pragma mark ANSCollectionObserver protocol

- (void)       collection:(ANSDataCollection *)collection
       didChangeWithModel:(ANSChangeModel *)model {
    UITableView *table = self.tableView.table;
    
    [model applyToTableView:table];
    
    NSLog(@"collectionDidUpdate, - %lu ", collection.count);
}

@end
