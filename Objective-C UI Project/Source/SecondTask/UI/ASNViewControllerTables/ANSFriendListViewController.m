//
//  ANSViewControllerTables.m
//  Objective-C UI Project
//
//  Created by Nikola Andriiev on 22.07.16.
//  Copyright © 2016 Andriiev.Mykola. All rights reserved.
//

#import "ANSFriendListViewController.h"

#import "ANSFriendListView.h"
#import "ANSUserCell.h"
#import "ANSTableViewCell.h"
#import "ANSFacebookUser.h"
#import "ANSFaceBookFriends.h"
#import "ANSImageModel.h"
#import "ANSImageView.h"
#import "ANSNameFilterModel.h"
#import "ANSFaceBookFriends.h"

#import "NSArray+ANSExtension.h"
#import "UINib+Extension.h"
#import "UITableView+Extension.h"
#import "ANSChangeModel.h"
#import "ANSChangeModel+UITableView.h"
#import "UIViewController+ANSExtension.h"
#import "ANSLoadingView.h"

#import "ANSMacros.h"
#import "ANSGCD.h"

static          NSString * const kANSEdit                    = @"Edit";
static          NSString * const kANSDone                    = @"Done";
static          NSString * const kANSTitleForHeaderSection   = @"User's friends";
static const    NSUInteger kANSSectionsCount                 = 1;

@interface ANSFriendListViewController ()
@property (nonatomic, strong)   ANSProtocolObservationController  *usersController;

@property (nonatomic, strong)   ANSNameFilterModel                *filteredModel;
@property (nonatomic, strong)   ANSProtocolObservationController  *filterModelController;
@property (nonatomic, readonly) ANSArrayModel *presentedModel;
@property (nonatomic, strong)   ANSFaceBookFriends *friends;

- (void)resignSearchBar;
- (void)initFilterInfrastructure;

@end

ANSViewControllerBaseViewProperty(ANSFriendListViewController, ANSFriendListView, friendListView)

@implementation ANSFriendListViewController;

@dynamic presentedModel;

#pragma mark -
#pragma mark Accsessors

- (void)setFriends:(ANSFaceBookFriends *)friends {
    if (_friends != friends) {
        _friends = friends;
        
        self.usersController = [friends protocolControllerWithObserver:self];
//        [self initFilterInfrastructure];
    }
}

- (void)setFilteredModel:(ANSNameFilterModel *)filteredModel {
    if (_filteredModel != filteredModel) {
        _filteredModel = filteredModel;
        
        self.filterModelController = [filteredModel protocolControllerWithObserver:self];
    }
}

- (ANSArrayModel *)presentedModel {
    BOOL isFirstResponder = self.friendListView.searchBar.isFirstResponder;
    
    return isFirstResponder ? self.filteredModel : self.friends;
}

#pragma mark -
#pragma mark View lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = kANSTitleForHeaderSection;
    [self initLeftBarButtonItem];
    [self initRightBarButtonItem];
// if no internet connerion
//  [self.friendListView.tableView reloadData];
}

#pragma mark -
#pragma mark Private methods

- (void)resignSearchBar {
    UISearchBar *searchBar = self.friendListView.searchBar;
    if (searchBar.isFirstResponder) {
        [self searchBarCancelButtonClicked:searchBar];
    }
}

- (void)initFilterInfrastructure {
    ANSFaceBookFriends *friends = self.friends;
    ANSNameFilterModel *nameFilterModel = [[ANSNameFilterModel alloc]
                                           initWithObservableModel:friends];
    self.filteredModel = nameFilterModel;
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
    UITableView *table = self.friendListView.tableView;
    
    [self resignSearchBar];
    
    if (table.editing) {
        // NO ACTION!
    }
}

- (void)rightBarAction:(UIBarButtonItem *)sender {
    UITableView *table = self.friendListView.tableView;
    
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
    return self.presentedModel.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ANSUserCell *cell = [tableView dequeueReusableCellWithClass:[ANSUserCell class]];
    
    ANSFacebookUser *user = self.presentedModel[indexPath.row];
    [cell fillWithUser:user];

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
        
        [self.friends performBlockWithoutNotification:^{
            [self.friends moveObjectFromIndex:sourceIndexPath.row
                                         toIndex:destinationIndexPath.row];
        }];
    }
}

- (void)    tableView:(UITableView *)tableView
    commitEditingStyle:(UITableViewCellEditingStyle)editingStyle
    forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        //NO ACTION! 
    }
}

#pragma mark -
#pragma mark UITableViewDelegate protocol

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView
           editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewCellEditingStyleDelete;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    id friendListViewController = [ANSFriendListViewController viewController];
    [self.navigationController pushViewController:friendListViewController
                                         animated:YES];
}

#pragma mark -
#pragma mark UISearchBarDelegate protocol

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    [searchBar resignFirstResponder];
    [searchBar setShowsCancelButton:NO animated:YES];
    
    [self.friendListView.tableView reloadData];
}

- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar {
    UITableView *table = self.friendListView.tableView;
    if (table.isEditing) {
        return NO;
    }
    
    return YES;
}

- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar {
    [searchBar setShowsCancelButton:YES animated:YES];
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    [self.filteredModel filterByfilterString:searchText];
}

#pragma mark -
#pragma mark ANSCollectionObserver protocol

- (void)    arrayModel:(ANSArrayModel *)arrayModel
    didChangeWithModel:(ANSChangeModel *)model
{
    ANSPerformInMainQueue(dispatch_async, ^{
        UITableView *table = self.friendListView.tableView;
        
        if ([arrayModel isMemberOfClass:[ANSFaceBookFriends class]]) {
            [model applyToTableView:table];
            NSLog(@"%@ notified collectionDidUpdate, - %lu object", arrayModel, (unsigned long)arrayModel.count);
        } else {
            NSLog(@"%@ notified collectionDidUpdate, - %lu object", arrayModel, (unsigned long)arrayModel.count);
        }
    });
}

- (void)loadableModelLoading:(ANSLoadableModel *)model {
    self.friendListView.loadingViewVisible = YES;
}

- (void)loadableModelDidLoad:(ANSLoadableModel *)model {
    ANSPerformInMainQueue(dispatch_async, ^{
        NSLog(@"notified userModelDidLoad");
        self.friendListView.loadingViewVisible = NO;
        [self.friendListView.tableView reloadData];
    });
}
 
- (void)nameFilterModelDidFilter:(ANSNameFilterModel *)model {
    ANSPerformInMainQueue(dispatch_async, ^{
        NSLog(@"notified didFilterWithUserInfo - %@ ", model);
        [self.friendListView.tableView reloadData];
    });
}

@end
