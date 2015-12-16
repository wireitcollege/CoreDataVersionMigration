//
//  AppDelegate+CoreData.m
//  CoreDataExample
//
//  Created by Admin on 12/10/15.
//  Copyright © 2015 Wire IT College. All rights reserved.
//

#import "AppDelegate+CoreData.h"
#import <objc/runtime.h>


static NSString *const kMOCKey = @"managedObjectContext";
static NSString *const kMOMKey = @"managedObjectModel";
static NSString *const kPSCKey = @"persistentStoreCoordinator";

@interface AppDelegate ()

@end

@implementation AppDelegate (CoreData)

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    // Saves changes in the application's managed object context before the application terminates.
    [self saveContext];
}

#pragma mark - Core Data stack

- (NSURL *)applicationDocumentsDirectory {
    // The directory the application uses to store the Core Data store file. This code uses a directory named "wire.edu.CoreDataExample" in the application's documents directory.
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

- (NSManagedObjectModel *)managedObjectModel {

    NSManagedObjectModel *managedObjectModel = objc_getAssociatedObject(self, (__bridge const void *)(kMOMKey));
    if (managedObjectModel) {
        return managedObjectModel;
    }
    
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"CoreDataExample" withExtension:@"momd"];
    managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    
    objc_setAssociatedObject(self, (__bridge const void *)(kMOMKey), managedObjectModel, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    return managedObjectModel;
}

- (NSPersistentStoreCoordinator *)persistentStoreCoordinator {

    NSPersistentStoreCoordinator *persistentStoreCoordinator = objc_getAssociatedObject(self, (__bridge const void *)(kPSCKey));
    if (persistentStoreCoordinator) {
        return persistentStoreCoordinator;
    }
    
    // Create the coordinator and store
    
    persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"CoreDataExample.sqlite"];
    
    NSDictionary *options = @{NSMigratePersistentStoresAutomaticallyOption: @YES,
                              NSInferMappingModelAutomaticallyOption: @NO};
    
    NSError *error = nil;
    NSString *failureReason = @"There was an error creating or loading the application's saved data.";
    if (![persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType
                                                  configuration:nil
                                                            URL:storeURL
                                                        options:options
                                                          error:&error]) {
        // Report any error we got.
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        dict[NSLocalizedDescriptionKey] = @"Failed to initialize the application's saved data";
        dict[NSLocalizedFailureReasonErrorKey] = failureReason;
        dict[NSUnderlyingErrorKey] = error;
        error = [NSError errorWithDomain:@"YOUR_ERROR_DOMAIN" code:9999 userInfo:dict];
        // Replace this with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    objc_setAssociatedObject(self, (__bridge const void *)(kPSCKey), persistentStoreCoordinator, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    return persistentStoreCoordinator;
}


- (NSManagedObjectContext *)managedObjectContext {
    NSManagedObjectContext *managedObjectContext = objc_getAssociatedObject(self, (__bridge const void *)(kMOCKey));
    if (managedObjectContext) {
        return managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (!coordinator) {
        return nil;
    }
    managedObjectContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
    [managedObjectContext setPersistentStoreCoordinator:coordinator];
    
    objc_setAssociatedObject(self, (__bridge const void *)(kMOCKey), managedObjectContext, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    return managedObjectContext;
}

#pragma mark - Core Data Saving support

- (void)saveContext {
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil) {
        NSError *error = nil;
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
            // Replace this implementation with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }
}

@end
