//
//  ANSViewControllerTables.m
//  Objective-C UI Project
//
//  Created by Nikola Andriiev on 22.07.16.
//  Copyright © 2016 Andriiev.Mykola. All rights reserved.
//
#import <FBSDKLoginKit/FBSDKLoginKit.h>

#import "ANSFriendListViewController.h"

#import "ANSFriendListView.h"
#import "ANSUserCell.h"
#import "ANSTableViewCell.h"
#import "ANSImageModel.h"
#import "ANSImageView.h"
#import "ANSNameFilterModel.h"
#import "ANSFBUser.h"
#import "ANSFBFriends.h"
#import "ANSFBFriendsContext.h"
#import "ANSUserDetailsViewController.h"
#import "ANSLoginViewController.h"

#import "NSArray+ANSExtension.h"
#import "UINib+Extension.h"
#import "UITableView+Extension.h"
#import "ANSChangeModel.h"
#import "ANSChangeModel+UITableView.h"
#import "UIViewController+ANSExtension.h"
#import "ANSLoadingView.h"

#import "ANSMacros.h"
#import "ANSGCD.h"

static          NSString * const kANSTitleForHeaderSection   = @"User's friends";
static const    NSUInteger kANSSectionsCount                 = 1;

ANSViewControllerBaseViewProperty(ANSFriendListViewController, ANSFriendListView, friendListView);

@interface ANSFriendListViewController ()
@property (nonatomic, strong)   ANSFBFriends                      *friends;
@property (nonatomic, strong)   ANSProtocolObservationController  *usersController;

@property (nonatomic, strong)   ANSNameFilterModel                *filteredModel;
@property (nonatomic, strong)   ANSProtocolObservationController  *filterModelController;

@property (nonatomic, strong)   ANSFBFriendsContext               *friendsContext;
@property (nonatomic, readonly) ANSArrayModel                     *presentedModel;;

- (void)resignSearchBar;
- (void)initFilterInfrastructure;

- (void)leftBarButtonAction:(UIBarButtonItem *)sender;
- (void)initLeftBarButton;

@end

@implementation ANSFriendListViewController;

@dynamic presentedModel;

#pragma mark -
#pragma Initialization and deallocation

- (instancetype)initWithCoder:(NSCoder *)coder {
    self = [super initWithCoder:coder];
    [self initLeftBarButton];
    
    return self;
}

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    [self initLeftBarButton];
   
    
    return self; 
}

#pragma mark -
#pragma mark Accsessors

- (void)setUser:(ANSFBUser *)user {
    if (_user != user) {
        _user = user;
        
        self.friends = [ANSFBFriends new];
        ANSFBFriendsContext *context = [[ANSFBFriendsContext alloc] initWithModel:self.friends];
        self.friendsContext = context;
        context.user = user;
        [context execute];
    }
}

- (void)setFriends:(ANSFBFriends *)friends {
    if (_friends != friends) {
        _friends = friends;
        
        self.usersController = [friends protocolControllerWithObserver:self];
        [self initFilterInfrastructure];
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
    ANSFBFriends *friends = self.friends;
    ANSNameFilterModel *nameFilterModel = [[ANSNameFilterModel alloc]
                                           initWithObservableModel:friends];
    self.filteredModel = nameFilterModel;
}

#pragma mark -
#pragma mark BarButtonItems

- (void)initLeftBarButton {
    UIBarButtonItem *leftButton = [[UIBarButtonItem alloc] initWithTitle:@"Return" style:UIBarButtonItemStylePlain target:self action:@selector(leftBarButtonAction:)];
    self.navigationItem.leftBarButtonItem = leftButton;
}

- (void)leftBarButtonAction:(UIBarButtonItem *)sender {
    [[FBSDKLoginManager new] logOut]; 
    [self.navigationController popViewControllerAnimated:YES];
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
    
    ANSFBUser *user = self.presentedModel[indexPath.row];
    [cell fillWithUser:user];

    return cell;
}

#pragma mark -
#pragma mark UITableViewDelegate protocol

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    ANSUserDetailsViewController *controller = nil;
    controller = [ANSUserDetailsViewController viewController];
    controller.user = self.friends[indexPath.row];
    
    [self.navigationController pushViewController:controller
                                         animated:YES];
}

#pragma mark -
#pragma mark UISearchBarDelegate protocol

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    [searchBar resignFirstResponder];
    [searchBar setShowsCancelButton:NO animated:YES];
    
    [self.friendListView.tableView reloadData];
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
        
        if ([arrayModel isMemberOfClass:[ANSFBFriends class]]) {
            [model applyToTableView:table];
            NSLog(@"%@ notified collectionDidUpdate, - %lu object", arrayModel, (unsigned long)arrayModel.count);
        } else {
            NSLog(@"%@ notified collectionDidUpdate, - %lu object", arrayModel, (unsigned long)arrayModel.count);
        }
    });
}

#pragma mark -
#pragma mark ANSLoadableModelObserver protocol

- (void)loadableModelLoading:(ANSLoadableModel *)model {
    ANSPerformInMainQueue(dispatch_async, ^{
        self.friendListView.loadingViewVisible = YES;
    });
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
