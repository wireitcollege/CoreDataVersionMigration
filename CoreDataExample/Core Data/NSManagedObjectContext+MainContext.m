//
//  NSManagedObjectContext+MainContext.m
//  CoreDataExample
//
//  Created by Admin on 12/10/15.
//  Copyright © 2015 Wire IT College. All rights reserved.
//

#import "NSManagedObjectContext+MainContext.h"
#import "AppDelegate+CoreData.h"

@implementation NSManagedObjectContext (MainContext)

+ (instancetype)mainContext {
    return [(AppDelegate *)[UIApplication sharedApplication].delegate managedObjectContext];
}

+ (instancetype)backgroundContext {
    NSManagedObjectContext *backgroundContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSPrivateQueueConcurrencyType];
    
    backgroundContext.parentContext = [self mainContext];
    
    return backgroundContext;
}

+ (void)saveContext {
    [(AppDelegate *)[UIApplication sharedApplication].delegate saveContext];
}

@end
