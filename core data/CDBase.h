//
//  CDBase.h
//  robin
//
//  Created by Alex Skorulis on 07/06/2013.
//  Copyright (c) 2013 Alex Skorulis. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CDBase : NSObject

@property (nonatomic, strong) NSManagedObjectContext* managedObjectContext;
@property (nonatomic, strong) NSPersistentStoreCoordinator* persistentStoreCoordinator;
@property (nonatomic, strong) NSManagedObjectModel* managedObjectModel;

- (NSString*) databaseName;
- (void) databaseCreated;
- (NSString*) databaseFilename;

@end
