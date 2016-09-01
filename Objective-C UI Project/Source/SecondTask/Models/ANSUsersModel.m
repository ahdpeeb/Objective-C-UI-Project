//
//  ANSDataCollection.m
//  Objective-C UI Project
//
//  Created by Nikola Andriiev on 24.07.16.
//  Copyright © 2016 Andriiev.Mykola. All rights reserved.
//
#import <UIKit/UIKit.h>

#import "ANSUsersModel.h"

#import "ANSUser.h"
#import "ANSMacros.h"
#import "ANSGCD.h"
#import "NSArray+ANSExtension.h"
#import "NSFileManager+ANSExtension.h"
#import "ANSNameFilterModel.h"
#import "ANSViewControllerTables.h"

static const NSUInteger kANSSleepTime = 5;
static const NSUInteger kANSUsersCount = 20;

static NSString * const kANSPlistName = @"aaa";

@interface ANSUsersModel ()
@property (nonatomic, weak) ANSNameFilterModel *nameFilterModel;

- (SEL)selectorForState:(NSUInteger)state;
- (id)usersFromFileSystem;
- (id)newUsers;
- (id)loadUsersModel;

@end

@implementation ANSUsersModel

#pragma mark -
#pragma mark Initilization and deallocation 

- (instancetype)init {
    self = [super init];
    if (self) {
        [self performBlockWithoutNotification:^{
            self.state = ANSUsersModelUnloaded;
        }];
        
    }
    return self;
}

#pragma mark -
#pragma mark Private methods

- (SEL)selectorForState:(NSUInteger)state {
    switch (state) {
        case ANSUsersModelDidLoad:
            return @selector(usersModelDidLoad:);
            
        default:
          return [super selectorForState:state];
    }
}

#pragma mark -
#pragma mark Private Methods

- (id)usersFromFileSystem  {
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *plistPath = [fileManager pathToPlistFile:kANSPlistName inSearchPathDirectory:NSDocumentDirectory];
    
    return [NSKeyedUnarchiver unarchiveObjectWithFile:plistPath];
}

- (id)newUsers {
    return [NSArray objectsWithCount:kANSUsersCount block:^id{
        return [ANSUser new];
    }];
}

- (id)loadUsersModel {
   id users = [self usersFromFileSystem];
    if (!users) {
        users = [self newUsers];
    }
    
    [self performBlockWithoutNotification:^{
        [self addObjectsInRange:users];
    }];
    
    sleep(kANSSleepTime);
    
    return users;
}

- (void)initFilterModelsInfrastructure {
    ANSNameFilterModel *nameFilterModel = self.nameFilterModel;
    if (!nameFilterModel) {
        nameFilterModel = [[ANSNameFilterModel alloc] initWithObservableModel:self];
        self.nameFilterModel = nameFilterModel;
        
        self.viewControllerObserver.filteredModel = nameFilterModel;
    }
}

#pragma mark -
#pragma mark Public methods

- (void)filterNameByfilterString:(NSString *)filterString {
    [self.nameFilterModel filterModelByfilterString:filterString];
}

- (NSArray *)descendingSortedUsers {
    NSMutableArray *users = [NSMutableArray arrayWithArray:self.objects];
    [users sortUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        if ([obj1 isKindOfClass:[ANSUser class]] && [obj2 isKindOfClass:[ANSUser class]]) {
             return [[obj1 string] compare:[obj2 string]];
        }
        
        return (NSComparisonResult)NSOrderedDescending;
    }];
    
    return users;
}

#pragma mark -
#pragma mark Save and loading(Public methods)

- (void)save {
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *plistPath = [fileManager pathToPlistFile:kANSPlistName inSearchPathDirectory:NSDocumentDirectory];
    BOOL isSuccessfully = [NSKeyedArchiver archiveRootObject:self.objects toFile:plistPath];
    NSLog(@"%@", (isSuccessfully) ? @"saved successfully" : @"save failed");
}

- (void)load {
    @synchronized(self) {
        ANSUserLoadingState state = self.state;
        if (state == ANSUsersModelLoading || state == ANSUsersModelDidLoad) {
            [self notifyOfStateChange:state];
            return;
        }
        
        if (state == ANSUsersModelUnloaded || state == ANSUsersModelDidFailLoading) {
            self.state = ANSUsersModelLoading;
            ANSWeakify(self);
            ANSPerformInAsyncQueue(ANSPriorityHigh, ^{
                ANSStrongify(self);
                id users = [self loadUsersModel];
                self.state = (users) ? ANSUsersModelDidLoad : ANSUsersModelDidFailLoading;
            });
        }
    }
}

@end
