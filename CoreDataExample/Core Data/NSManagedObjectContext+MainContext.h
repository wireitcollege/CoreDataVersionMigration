//
//  NSManagedObjectContext+MainContext.h
//  CoreDataExample
//
//  Created by Admin on 12/10/15.
//  Copyright © 2015 Wire IT College. All rights reserved.
//

#import <CoreData/CoreData.h>

@interface NSManagedObjectContext (MainContext)

+ (instancetype)mainContext;
+ (instancetype)backgroundContext;
+ (void)saveContext;

@end
