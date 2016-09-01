//
//  ANSViewControllerTables.m
//  Objective-C UI Project
//
//  Created by Nikola Andriiev on 22.07.16.
//  Copyright © 2016 Andriiev.Mykola. All rights reserved.
//

#import "ANSViewControllerTables.h"

#import "ANSRootTableView.h"
#import "ANSUserCell.h"
#import "ANSTableViewCell.h"
#import "ANSUser.h"
#import "ANSImageModel.h"
#import "ANSImageView.h"
#import "ANSNameFilterModel.h"

#import "NSArray+ANSExtension.h"
#import "UINib+Extension.h"
#import "UITableView+Extension.h"
#import "ANSChangeModel.h"
#import "ANSChangeModel+UITableView.h"
#import "UIViewController+ANSExtension.h"
#import "ANSLoadingView.h"

#import "ANSMacros.h"
#import "ANSGCD.h"

static NSString * const kANSEdit                    = @"Edit";
static NSString * const kANSDone                    = @"Done";
static NSString * const kANSTitleForHeaderSection   = @"Homer's contact list";
static const NSUInteger kANSSectionsCount           = 1;

@interface ANSViewControllerTables ()
@property (nonatomic, strong) ANSProtocolObservationController  *usersController;

// the controller monitors the latest filtering model
@property (nonatomic, strong) ANSProtocolObservationController *filterModelController;

- (void)resignSearchBar;
- (ANSUsersModel *)presentedModel;

@end

ANSViewControllerBaseViewProperty(ANSViewControllerTables, ANSRootTableView, rootView)

@implementation ANSViewControllerTables;

#pragma mark -
#pragma mark Accsessors

- (void)setUsers:(ANSUsersModel *)users {
    if (_users != users) {
        _users = users;
        _users.viewControllerObserver = self;
        
        self.usersController = [users protocolControllerWithObserver:self];
        [users initFilterModelsInfrastructure];
    }
}

- (void)setFilteredModel:(ANSNameFilterModel *)filteredModel {
    if (_filteredModel != filteredModel) {
        _filteredModel = filteredModel;
        _filteredModel.viewControllerObserver = self;
        
        self.filterModelController = [filteredModel protocolControllerWithObserver:self];
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

- (void)viewWillAppear:(BOOL)animated {
    [self.users load];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark -
#pragma mark Private methods

- (void)resignSearchBar {
    UISearchBar *searchBar = self.rootView.searchBar;
    if (searchBar.isFirstResponder) {
        [self searchBarCancelButtonClicked:searchBar];
    }
}

- (ANSUsersModel *)presentedModel {
    BOOL isFirstResponder = self.rootView.searchBar.isFirstResponder;
    return isFirstResponder ? (ANSUsersModel *)self.filteredModel : self.users;
}

#pragma mark -
#pragma mark UIBarButtonItems

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
    UITableView *table = self.rootView.tableView;
    
    [self resignSearchBar];
    
    if (table.editing) {
        ANSUser *object = [[ANSUser alloc] init];
        [self.users performBlockWithNotification:^{
            [self.users insertObject:object atIndex:0];
        }];
    }
}

- (void)rightBarAction:(UIBarButtonItem *)sender {
    UITableView *table = self.rootView.tableView;
    
    [self resignSearchBar];
    
    BOOL isEditing = table.editing;
    [sender setTitle:(isEditing ? kANSEdit : kANSDone)];
    [table setEditing:(isEditing ? NO : YES) animated:YES];
}

#pragma mark -
#pragma mark Gestures

- (IBAction)onRightSwipe:(UISwipeGestureRecognizer *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark -
#pragma mark UITableViewDataSource protocol

- (nullable NSString *)tableView:(UITableView *)tableView
         titleForHeaderInSection:(NSInteger)section
{
    return section ? nil : kANSTitleForHeaderSection;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return kANSSectionsCount;
}

- (NSInteger)   tableView:(UITableView *)tableView
    numberOfRowsInSection:(NSInteger)section
{
    return [self presentedModel].count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ANSUserCell *cell = [tableView reusableCellfromNibWithClass:[ANSUserCell class]];
    
    ANSUser *user = nil;
    user = [self presentedModel][indexPath.row];
    
    [cell fillWithModel:user];

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
        
        [self.users performBlockWithoutNotification:^{
            [self.users moveObjectFromIndex:sourceIndexPath.row
                                         toIndex:destinationIndexPath.row];
        }];
    }
}

- (void)    tableView:(UITableView *)tableView
    commitEditingStyle:(UITableViewCellEditingStyle)editingStyle
    forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        ANSUsersModel *users = self.users;
        [users performBlockWithNotification:^{
            [users removeObjectAtIndex:indexPath.row];
        }];
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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    id controller = [ANSViewControllerTables viewController];
    [self.navigationController pushViewController:controller animated:YES];
}

#pragma mark -
#pragma mark UISearchBarDelegate protocol

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    [searchBar resignFirstResponder];
    [searchBar setShowsCancelButton:NO animated:YES];
    
    [self.rootView.tableView reloadData];
}

- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar {
    UITableView *table = self.rootView.tableView;
    if (table.isEditing) {
        return NO;
    }
    
    return YES;
}

- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar {
    [searchBar setShowsCancelButton:YES animated:YES];
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    [self.users filterNameByfilterString:searchText];
}

#pragma mark -
#pragma mark ANSCollectionObserver protocol

- (void)    arrayModel:(ANSArrayModel *)arrayModel
    didChangeWithModel:(ANSChangeModel *)model
{
    ANSPerformInMainQueue(dispatch_async, ^{
        UITableView *table = self.rootView.tableView;
        
        if ([arrayModel isMemberOfClass:[ANSUsersModel class]]) {
            [model applyToTableView:table];
            NSLog(@"%@ notified collectionDidUpdate, - %lu object", arrayModel, arrayModel.count);
        } else {
            NSLog(@"OtherModel");
        }
    });
}

- (void)usersModelDidLoad:(ANSUsersModel *)model {
    ANSPerformInMainQueue(dispatch_async, ^{
        NSLog(@"notified userModelDidLoad");
        self.rootView.loadingViewVisible = NO;
        [self.rootView.tableView reloadData];
    });
}

- (void)nameFilterModelDidFilter:(ANSNameFilterModel *)model {
    ANSPerformInMainQueue(dispatch_async, ^{
        NSLog(@"notified didFilterWithUserInfo - %@ ", model);
        [self.rootView.tableView reloadData];
    });
}

@end
