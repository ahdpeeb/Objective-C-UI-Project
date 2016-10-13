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
#import "ANSImageModel.h"
#import "ANSImageView.h"
#import "ANSUser.h"
#import "ANSUserFriends.h"
#import "ANSFriendsContext.h"
#import "ANSUserDetailsViewController.h"
#import "ANSLoginViewController.h"

#import "NSArray+ANSExtension.h"
#import "UINib+Extension.h"
#import "UITableView+Extension.h"
#import "ANSChangeModel.h"
#import "ANSChangeModel+UITableView.h"
#import "UIViewController+ANSExtension.h"
#import "ANSLoadingView.h"
#import "ANSCoreDataManager.h"
#import "NSManagedObject+ANSExtension.h"

#import "ANSMacros.h"
#import "ANSGCD.h"

ANSViewControllerBaseViewProperty(ANSFriendListViewController, ANSFriendListView, friendListView);

@interface ANSFriendListViewController ()
@property (nonatomic, strong) ANSProtocolObservationController  *userController;

@property (nonatomic, strong) ANSUserFriends                    *userFriends;
@property (nonatomic, strong) ANSProtocolObservationController  *userFriendsController;

@property (nonatomic, strong) ANSFriendsContext                 *friendsContext;

- (void)leftBarButtonAction:(UIBarButtonItem *)sender;
- (void)initLeftBarButton;

@end

@implementation ANSFriendListViewController;

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

- (void)setUser:(ANSUser *)user {
    if (_user != user) {
        _user = user;
        
        ANSFriendsContext *context = [[ANSFriendsContext alloc] initWithModel:user];
        self.friendsContext = context;
        
        self.userController = [user protocolControllerWithObserver:self];
        
        [context execute];
    }
}

- (void)setUserFriends:(ANSUserFriends *)userFriends {
    if (_userFriends != userFriends) {
        _userFriends = userFriends;
        
        self.userFriendsController = [userFriends protocolControllerWithObserver:self];
    }
}

#pragma mark -
#pragma mark View lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
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
#pragma mark Private methods

#pragma mark -
#pragma mark UITableViewDataSource protocol

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)   tableView:(UITableView *)tableView
    numberOfRowsInSection:(NSInteger)section
{
    return self.userFriends.count;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ANSUserCell *cell = [tableView dequeueReusableCellWithClass:[ANSUserCell class]];
    
    ANSUser *user = [self.resultsController objectAtIndexPath:indexPath];
    [cell fillWithUser:user];

    return cell;
}

#pragma mark -
#pragma mark UITableViewDelegate protocol

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    ANSUserDetailsViewController *controller = nil;
    controller = [ANSUserDetailsViewController viewController];
    ANSUser *user = [self.resultsController objectAtIndexPath:indexPath];
    
    controller.user = user;
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
//    [self.filteredModel filterByfilterString:searchText];
}

#pragma mark -
#pragma mark NSFetchedResultsControllerDelegate protocol

- (void)controllerWillChangeContent:(NSFetchedResultsController *)controller {
    [self.friendListView.tableView beginUpdates];
}

- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller {
    [self.friendListView.tableView endUpdates];
}

#pragma mark -
#pragma mark ANSUserObserver protocol

- (void)loadableModelDidLoad:(ANSLoadableModel *)model; {
    ANSPerformAsyncOnMainQueue(^{
        [self.friendListView.tableView reloadData];
        self.friendListView.loadingView.visible = NO;
    });
}

@end
