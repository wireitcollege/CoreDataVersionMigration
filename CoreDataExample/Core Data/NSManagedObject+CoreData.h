//
//  NSManagedObject+CoreData.h
//  CoreDataExample
//
//  Created by Admin on 12/10/15.
//  Copyright © 2015 Wire IT College. All rights reserved.
//

#import <CoreData/CoreData.h>

@interface NSManagedObject (CoreData)

+ (instancetype)createEntity;
+ (instancetype)createEntityInContext:(NSManagedObjectContext *)context;

+ (NSFetchRequest *)request;
+ (NSFetchRequest *)requestSortedBy:(NSString *)key ascending:(BOOL)ascending predicate:(NSPredicate *)predicate;

+ (instancetype)findFirstWithPredicate:(NSPredicate *)predicate
                              sortedBy:(NSString *)key
                             ascending:(BOOL)ascending
                             inContext:(NSManagedObjectContext *)context;
+ (instancetype)findFirstWithPredicate:(NSPredicate *)predicate inContext:(NSManagedObjectContext *)context;
+ (instancetype)findFirstWithPredicate:(NSPredicate *)predicate;

+ (NSArray *)allObjects;
+ (NSArray *)allObjectsInContext:(NSManagedObjectContext *)context;
+ (NSArray *)allObjectsSortedBy:(NSString *)key ascending:(BOOL)ascending predicate:(NSPredicate *)predicate inContext:(NSManagedObjectContext *)context;
+ (NSArray *)allObjectsSortedBy:(NSString *)key ascending:(BOOL)ascending predicate:(NSPredicate *)predicate;
+ (NSArray *)allObjectsSortedBy:(NSString *)key ascending:(BOOL)ascending;


+ (NSFetchedResultsController *)fetchedResultsSortedBy:(NSString *)key
                                             ascending:(BOOL)ascending
                                             predicate:(NSPredicate *)predicate
                                             groupedBy:(NSString *)grouped
                                             inContext:(NSManagedObjectContext *)context;

- (void)deleteEntity;

@end
