//
//  ANSCoreDataManager.m
//  Objective-C UI Project
//
//  Created by Nikola Andriiev on 04.10.16.
//  Copyright © 2016 Andriiev.Mykola. All rights reserved.
//

#import "ANSCoreDataManager.h"

#import "NSFileManager+ANSExtension.h"

static NSString * const kANSMomExtension =  @"momd";
static NSString * const kANSSqlite       =  @".sqlite";

@interface ANSCoreDataManager ()
@property (nonatomic, strong) NSManagedObjectContext       *managedObjectContext;
@property (nonatomic, strong) NSPersistentStoreCoordinator *persistentStoreCoordinator;
@property (nonatomic, strong) NSManagedObjectModel         *managedObjectModel;

@property (nonatomic, copy)     NSString     *momName;
@property (nonatomic, copy)     NSString     *storeName;
@property (nonatomic, assign)   ANSStoreType storeType;
@property (nonatomic, readonly) NSString   *projectName;
@property (nonatomic, readonly) NSString   *

@end

@implementation ANSCoreDataManager

@dynamic projectName;

#pragma mark -
#pragma mark Class methods

- (instancetype)initWithMomName:(NSString *)momName
                      storeName:(NSString *)storeName
                      storeType:(ANSStoreType)storeType
{
    self = [super init];
    self.momName = momName;
    self.storeName = storeName;
    self.storeType = storeType;
    
    return self;
}

+ (instancetype)managerWithMomName:(NSString *)momName {
    return [self managerWithMomName:momName storeName:nil storeType:0];
}

+ (instancetype)managerWithMomName:(NSString *)momName
                         storeName:(NSString *)storeName
                         storeType:(ANSStoreType)storeType;
{
    static ANSCoreDataManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[ANSCoreDataManager alloc] initWithMomName:momName storeName:storeName storeType:storeType];
        [manager raiseInfrastructure];
    });

    return manager;
}

#pragma mark -
#pragma mark Accsessors

- (NSString *)projectName {
    return  [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleName"];
}

- (NSManagedObjectModel *)managedObjectModel {
    NSString *momName = self.momName;
    if (!momName) {
        return nil;
    }
    
    if (_managedObjectModel) {
        return _managedObjectModel;
    }
    
    NSURL *url = [[NSBundle mainBundle] URLForResource:momName withExtension:kANSMomExtension];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:url];
    
    return _managedObjectModel;
}

- (NSPersistentStoreCoordinator *)persistentStoreCoordinator {
    if (_persistentStoreCoordinator ) {
        return _persistentStoreCoordinator;
    }
    
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:self.managedObjectModel];
    NSString *storeType = [self stringFromStoreType:self.storeType];
    NSError *error = nil;
    
    [_persistentStoreCoordinator addPersistentStoreWithType:storeType configuration:nil URL:<#(nullable NSURL *)#> options:nil error:&error];
    
    return _persistentStoreCoordinator;
}

- (NSManagedObjectContext *)managedObjectContext {
    if (_managedObjectContext) {
        return _managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = self.persistentStoreCoordinator;
    if (coordinator) {
        _managedObjectContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSPrivateQueueConcurrencyType];
        _managedObjectContext.persistentStoreCoordinator = coordinator;
    }
    
    return _managedObjectContext;
}

#pragma mark -
#pragma mark Private 

- (void)raiseInfrastructure {
    NSLog(@"raise - %@", self.managedObjectContext);
}

- (NSString *)stringFromStoreType:(ANSStoreType)storeType {
    switch (storeType) {
        case ANSStoreTypeSQLLite:  return NSSQLiteStoreType;
        case ANSStoreTypeBinary:   return NSBinaryStoreType;
        case ANSStoreTypeInMemory: return NSInMemoryStoreType;
    }
}

- (NSURL *)persistentStoreURL {
    NSString *fileName = nil;
    if (!self.storeName) {
        fileName = [NSString stringWithFormat:@"%@%@"[self projectName]]
    }
}

@end
