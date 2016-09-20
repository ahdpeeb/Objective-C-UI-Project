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

#import "ANSMacros.h"

ANSViewControllerBaseViewProperty(ANSLoginViewController, ANSLoginView, loginView);

@interface ANSLoginViewController ()

- (void)loadFriens;

@end

@implementation ANSLoginViewController

#pragma mark -
#pragma mark View lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)loadFriens {
    if  (![FBSDKAccessToken currentAccessToken]) {
        return;
    }
    
    FBSDKGraphRequest *request = [[FBSDKGraphRequest alloc]
                                  initWithGraphPath:@"me"
                                         parameters:@{@"fields": @"id, name, gender"}
                                         HTTPMethod:@"GET"];
    
    [request startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection,
                                          NSDictionary *result,
                                          NSError *error) {
        if (error) {
            NSLog(@"%@", error);
            return;
        }
        NSString *bla  = [result objectForKey:@"name"];
        NSString *bla2 = [result objectForKey:@"id"];
        NSString *bla3 = [result objectForKey:@"gender"];
        NSArray *friends = [result objectForKey:@"data"];
  //      NSLog(@"I have a friend named %@ with id %@", friend.name, friend.objectID);
    }];
}

#pragma mark -
#pragma mark Buttons

- (IBAction)onLogin:(UIButton *)sender {
    FBSDKLoginManager *manager = [FBSDKLoginManager new];
    [manager logInWithReadPermissions:@[@"public_profile", @"user_friends", @"read_custom_friendlists"]
                   fromViewController:self
                              handler:^(FBSDKLoginManagerLoginResult *result, NSError *error) {
                                  if (!error && !result.isCancelled) {
                                      NSLog(@"Loggined");
                                      [self loadFriens];
                                  }
                              }];
    
}
     
@end
