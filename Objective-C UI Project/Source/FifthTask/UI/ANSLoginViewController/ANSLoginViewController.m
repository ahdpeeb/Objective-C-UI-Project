//
//  ANSLoginViewController.m
//  Objective-C UI Project
//
//  Created by Nikola Andriiev on 20.09.16.
//  Copyright © 2016 Andriiev.Mykola. All rights reserved.
//

#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>
#import <CoreData/CoreData.h>

#import "ANSLoginViewController.h"

#import "ANSLoginView.h"
#import "ANSFBUser.h"
#import "ANSFBFriends.h"
#import "ANSFriendListViewController.h"
#import "ANSFBLoginContext.h"
#import "ANSProtocolObservationController.h"
#import "ANSFBConstatns.h"
#import "ANSLoginInterection.h"
#import "ANSUser.h"

#import "UIViewController+ANSExtension.h"
#import "NSManagedObject+ANSExtension.h"

#import "ANSMacros.h"

ANSViewControllerBaseViewProperty(ANSLoginViewController, ANSLoginView, loginView);

@interface ANSLoginViewController ()
@property (nonatomic, strong) ANSFBLoginContext                     *loginContext;

@property (nonatomic, strong) ANSFBUser                             *user;
@property (nonatomic, strong) ANSProtocolObservationController      *contoller;

- (void)autoLogin;

@end

@implementation ANSLoginViewController

#pragma mark -
#pragma mark View lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self autoLogin];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)setUser:(ANSFBUser *)user {
    if (_user != user) {
        _user = user;

        self.contoller = [user protocolControllerWithObserver:self];
    }
}

#pragma mark -
#pragma mark Private metods

- (void)autoLogin {
    self.user = [ANSFBUser new];
    ANSLoginInterection *interection = [ANSLoginInterection interectionWithUser:self.user];
    [interection execute];
}

#pragma mark -
#pragma mark Buttons actions

- (IBAction)onLogin:(UIButton *)sender {
    self.user = [ANSFBUser new];
    self.loginContext = [[ANSFBLoginContext alloc] initWithModel:self.user controller:self];
    [self.loginContext execute];
}

- (IBAction)onCoreDataTest:(UIButton *)sender {
//    for (NSUInteger index = 0; index < 100; index ++) {
//        ANSUser *user = [ANSUser newObject];
//        [user fillWithRandom];
//        [user save];
//    }
    
    NSArray *users = [ANSUser objectsFromBase];
    NSString *word = @"ab";
    NSPredicate *namePredicate = [NSPredicate predicateWithFormat:@"(firstName CONTAINS[c] %@)", word];
    NSArray *filteredUsers = [ANSUser objectsFromBaseWithSortDescriptors:nil predicate:namePredicate batchCount:0];
    
    NSLog(@"users.count - %lu", (unsigned long)filteredUsers.count);
}

#pragma mark -
#pragma mark ANSUserStateObserver ptotocol 

- (void)userDidLoadID:(ANSFBUser *)user {
    ANSFriendListViewController *controller = [ANSFriendListViewController viewController];
    controller.user = user;
    [self.navigationController pushViewController:controller animated:YES];
}

@end
