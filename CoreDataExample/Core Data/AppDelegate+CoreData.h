//
//  AppDelegate+CoreData.h
//  CoreDataExample
//
//  Created by Admin on 12/10/15.
//  Copyright © 2015 Wire IT College. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate (CoreData)

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;

@end
