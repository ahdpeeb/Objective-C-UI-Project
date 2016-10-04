//
//  ANSCoreDataManager.h
//  Objective-C UI Project
//
//  Created by Nikola Andriiev on 04.10.16.
//  Copyright © 2016 Andriiev.Mykola. All rights reserved.
//

#import <CoreData/CoreData.h>
#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, ANSStoreType) {
    ANSStoreTypeSQLLite,
    ANSStoreTypeBinary,
    ANSStoreTypeInMemory
};

@interface ANSCoreDataManager : NSObject
@property (nonatomic, readonly) NSManagedObjectContext       *managedObjectContext;
@property (nonatomic, readonly) NSManagedObjectModel         *managedObjectModel;
@property (nonatomic, readonly) NSPersistentStoreCoordinator *persistentStoreCoordinator;

//MOM name in main bunble. default store type ANSStoreTypeSQLLite;
+ (instancetype)managerWithMomName:(NSString *)momName;

// custom store name must contains file extension
+ (instancetype)managerWithMomName:(NSString *)momName
                         storeName:(NSString *)storeName
                         storeType:(ANSStoreType)storeType;

@end
