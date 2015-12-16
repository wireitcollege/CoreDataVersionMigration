//
//  NSManagedObject+CoreData.m
//  CoreDataExample
//
//  Created by Admin on 12/10/15.
//  Copyright © 2015 Wire IT College. All rights reserved.
//

#import "NSManagedObject+CoreData.h"
#import "NSManagedObjectContext+MainContext.h"

@implementation NSManagedObject (CoreData)

+ (NSString *)entityName {
    return NSStringFromClass(self);
}

+ (instancetype)createEntityInContext:(NSManagedObjectContext *)context {
    return [NSEntityDescription insertNewObjectForEntityForName:[self entityName]
                                         inManagedObjectContext:context];
}

+ (instancetype)createEntity {
    return [self createEntityInContext:[NSManagedObjectContext mainContext]];
}

+ (NSFetchRequest *)request {
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:[self entityName]];
    return request;
}

+ (NSFetchRequest *)requestSortedBy:(NSString *)key
                          ascending:(BOOL)ascending
                          predicate:(NSPredicate *)predicate
{
    NSFetchRequest *request = [self request];
    request.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:key ascending:ascending]];
    request.predicate = predicate;
    return request;
}

+ (instancetype)findFirstWithPredicate:(NSPredicate *)predicate
                              sortedBy:(NSString *)key
                             ascending:(BOOL)ascending
                             inContext:(NSManagedObjectContext *)context
{
    NSFetchRequest *request = [self request];
    if (key) {
        request.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:key ascending:ascending]];
    }
    request.predicate = predicate;
    
    NSArray *results = [context executeFetchRequest:request error:NULL];
    return results.firstObject;
}

+ (instancetype)findFirstWithPredicate:(NSPredicate *)predicate inContext:(NSManagedObjectContext *)context {
    return [self findFirstWithPredicate:predicate sortedBy:nil ascending:YES inContext:context];
}

+ (instancetype)findFirstWithPredicate:(NSPredicate *)predicate {
    return [self findFirstWithPredicate:predicate inContext:[NSManagedObjectContext mainContext]];
}

+ (NSArray *)allObjects {
    return [self allObjectsInContext:[NSManagedObjectContext mainContext]];
}

+ (NSArray *)allObjectsInContext:(NSManagedObjectContext *)context {
    NSFetchRequest *request = [self request];
    NSError *error;
    NSArray *results = [context executeFetchRequest:request error:&error];
    if (error) {
        NSLog(@"error: %@", error);
    }
    return results;
}

+ (NSArray *)allObjectsSortedBy:(NSString *)key
                      ascending:(BOOL)ascending
                      predicate:(NSPredicate *)predicate
{
    return [self allObjectsSortedBy:key
                          ascending:ascending
                          predicate:predicate
                          inContext:[NSManagedObjectContext mainContext]];
}

+ (NSArray *)allObjectsSortedBy:(NSString *)key
                      ascending:(BOOL)ascending
                      predicate:(NSPredicate *)predicate
                      inContext:(NSManagedObjectContext *)context
{
    NSFetchRequest *request = [self requestSortedBy:key ascending:ascending predicate:predicate];
    NSError *error;
    NSArray *results = [context executeFetchRequest:request error:&error];
    if (error) {
        NSLog(@"error: %@", error);
    }
    return results;
}

+ (NSArray *)allObjectsSortedBy:(NSString *)key
                      ascending:(BOOL)ascending
{
    return [self allObjectsSortedBy:key
                          ascending:ascending
                          predicate:nil
                          inContext:[NSManagedObjectContext mainContext]];
}

+ (NSFetchedResultsController *)fetchedResultsSortedBy:(NSString *)key
                                             ascending:(BOOL)ascending
                                             predicate:(NSPredicate *)predicate
                                             groupedBy:(NSString *)grouped
                                             inContext:(NSManagedObjectContext *)context
{
    NSFetchRequest *request = [self requestSortedBy:@"name" ascending:YES predicate:nil];
    NSFetchedResultsController *controller =
    [[NSFetchedResultsController alloc] initWithFetchRequest:request
                                        managedObjectContext:context
                                          sectionNameKeyPath:grouped
                                                   cacheName:nil];
    NSError *error;
    if (![controller performFetch:&error]) {
        NSLog(@"Error: %@", error);
    }
    return controller;
}

- (void)deleteEntity {
    NSManagedObjectContext *context = self.managedObjectContext;
    [context deleteObject:self];
}

@end
