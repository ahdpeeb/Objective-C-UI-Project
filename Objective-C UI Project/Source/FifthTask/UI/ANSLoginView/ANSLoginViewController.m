//
//  ANSLoginViewController.m
//  Objective-C UI Project
//
//  Created by Nikola Andriiev on 20.09.16.
//  Copyright © 2016 Andriiev.Mykola. All rights reserved.
//

#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>

#import "ANSLoginViewController.h"

#import "ANSLoginView.h"
#import "ANSFaceBookUser.h"
#import "ANSFaceBookFriends.h"
#import "ANSFriendListViewController.h"

#import "UIViewController+ANSExtension.h"

#import "ANSMacros.h"

ANSViewControllerBaseViewProperty(ANSLoginViewController, ANSLoginView, loginView);

@interface ANSLoginViewController ()
@property (nonatomic, strong) FBSDKLoginManager *LoginManager;

- (void)loadFriends;
- (NSArray *)usersFromFrinds:(NSArray *)friends;

@end

@implementation ANSLoginViewController

#pragma mark -
#pragma mark View lifecycle

- (void)viewDidLoad {
    self.LoginManager = [FBSDKLoginManager new];
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark -
#pragma mark Private methods

//- (NSArray *)usersFromFrinds:(NSArray *)friends {
//    NSMutableArray *users = [NSMutableArray new];
//    for (NSDictionary *frind in friends) {
//        ANSFaceBookUser *user = [ANSFaceBookUser new];
//        user.ID = (NSInteger)[frind objectForKey:@"id"];
//        user.firsName = [frind objectForKey:@"first_name"];
//        user.lastName = [frind objectForKey:@"last_name"];
//        
//        NSDictionary * dataPicture = [[frind objectForKey:@"picture"] objectForKey:@"data"];
//        NSString *URLString = [dataPicture objectForKey:@"url"];
//        user.imageUrl = [NSURL URLWithString:URLString];
//        
//        NSLog(@"user id = %lu, fullName - %@ %@, picture - %@",user.ID,
//                                                              user.firsName,
//                                                              user.lastName,
//                                                              user.imageUrl);
//        [users addObject:user];
//    }
//    
//    return [NSArray arrayWithArray:users];
//}

- (void)loadFriends {
    if  (![FBSDKAccessToken currentAccessToken]) {
        return;
    }
    
    FBSDKGraphRequest *request = nil;
    request = [[FBSDKGraphRequest alloc]
              initWithGraphPath:@"me/friends"
                     parameters:@{@"fields": @"id, first_name, last_name, picture.type(large)"}
                     HTTPMethod:@"GET"];
    
    [request startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection,
                                          NSDictionary *result,
                                          NSError *error) {
        if (error) {
            NSLog(@"%@", error);
            return;
        }
        
        NSArray *friends = [result objectForKey:@"data"];
        NSArray *users = [self usersFromFrinds:friends];
        
        ANSFaceBookFriends *faceBookFriends = [ANSFaceBookFriends new];
        [faceBookFriends addObjectsInRange:users];
        NSLog(@"faceBookFriends count = %lu", (unsigned long)faceBookFriends.count);
        
        ANSFriendListViewController *controller = [ANSFriendListViewController viewController];
        controller.friends = faceBookFriends;
        [self.navigationController pushViewController:controller animated:YES];
    }];
}

#pragma mark -
#pragma mark Buttons actions

- (IBAction)onLogin:(UIButton *)sender {
    [self.LoginManager logInWithReadPermissions:@[@"public_profile", @"user_friends"]
                   fromViewController:self
                              handler:^(FBSDKLoginManagerLoginResult *result, NSError *error) {
                                  BOOL value = result.isCancelled;
                                  if (!error && !value) {
                                      NSLog(@"Loggined");
                                      [self loadFriends];
                                  }
                              }];
    
}
     
@end
