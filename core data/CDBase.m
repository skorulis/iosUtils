//
//  CDBase.m
//  robin
//
//  Created by Alex Skorulis on 07/06/2013.
//  Copyright (c) 2013 Alex Skorulis. All rights reserved.
//

#import "CDBase.h"
#import <CoreData/CoreData.h>

@implementation CDBase

- (NSManagedObjectContext *)managedObjectContext {
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (coordinator != nil) {
        _managedObjectContext = [[NSManagedObjectContext alloc] init];
        [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    }
    return _managedObjectContext;
}

- (NSManagedObjectModel *)managedObjectModel {
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:[self databaseName] withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}

- (NSPersistentStoreCoordinator *)persistentStoreCoordinator {
    if (_persistentStoreCoordinator == nil) {
        [self createPersistentStore:TRUE];
    }
    
    return _persistentStoreCoordinator;
}

- (void) createPersistentStore:(BOOL)firstAttempt {
    NSURL *url = [[CDBase applicationDocumentsDirectory] URLByAppendingPathComponent:[self databaseFilename]];
    
    NSError *error = nil;
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:url options:nil error:&error]) {
        
        if(firstAttempt && error.code == 134100) {
            [self deletePersistentStore];
            [self createPersistentStore:FALSE];
        } else {
            NSLog(@"Cannot handle error: %@, %@", error, [error userInfo]);
            abort();
        }
    }
}

- (void) deletePersistentStore {
    NSURL *storeURL = [[CDBase applicationDocumentsDirectory] URLByAppendingPathComponent:[self databaseFilename]];
    NSFileManager *localFileManager = [[NSFileManager alloc] init];
    [localFileManager removeItemAtURL:storeURL error:nil];
}

+ (NSURL *)applicationDocumentsDirectory {
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

- (NSString*) databaseFilename {
    return [NSString stringWithFormat:@"%@.sqlite",[self databaseName]];
}

- (NSString*) databaseName {
    [NSException raise:@"Database name not implemented" format:@"Database name not implemented"];
    return nil;
}

@end
