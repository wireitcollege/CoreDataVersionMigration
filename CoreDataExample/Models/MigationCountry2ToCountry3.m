//
//  MigationCountry2ToCountry3.m
//  CoreDataExample
//
//  Created by Admin on 16.12.15.
//  Copyright © 2015 Wire IT College. All rights reserved.
//

#import "MigationCountry2ToCountry3.h"
#import "Country+CoreDataProperties.h"
#import "Region+CoreDataProperties.h"

@implementation MigationCountry2ToCountry3

- (BOOL)beginEntityMapping:(NSEntityMapping *)mapping
                   manager:(NSMigrationManager *)manager
                     error:(NSError * _Nullable __autoreleasing *)error
{
    NSMutableDictionary *userInfo = [@{} mutableCopy];
    userInfo[@"regions"] = [@{} mutableCopy];
    manager.userInfo = userInfo;
    
    return YES;
}

- (BOOL)createDestinationInstancesForSourceInstance:(Country *)sourceCountry
                                      entityMapping:(NSEntityMapping *)mapping
                                            manager:(NSMigrationManager *)manager
                                              error:(NSError * _Nullable __autoreleasing *)error
{
    NSManagedObjectContext *destinationContext = [manager destinationContext];
    NSString *destinationEntityName = [mapping destinationEntityName];
    
    Country *destinationCountry = (Country *)[NSEntityDescription insertNewObjectForEntityForName:destinationEntityName
                                                                           inManagedObjectContext:destinationContext];
    
    destinationCountry.name = sourceCountry.name;
    destinationCountry.population = sourceCountry.population;
    destinationCountry.area = sourceCountry.area;
    destinationCountry.nativeName = sourceCountry.nativeName;
    destinationCountry.latitude = sourceCountry.latitude;
    destinationCountry.longitude = sourceCountry.longitude;
    destinationCountry.capital = sourceCountry.capital;
    
    NSString *regionName = [sourceCountry valueForKey:@"region"];
    if (regionName) {
        NSMutableDictionary *regions = manager.userInfo[@"regions"];
        Region *region = regions[regionName];
        if (!region) {
            region = (Region *)[NSEntityDescription insertNewObjectForEntityForName:@"Region"
                                                             inManagedObjectContext:destinationContext];
            region.name = regionName;
            regions[regionName] = region;
        }
        
        destinationCountry.region = region;
    }
    
    
    [manager associateSourceInstance:sourceCountry
             withDestinationInstance:destinationCountry
                    forEntityMapping:mapping];
    
    return YES;
}

- (BOOL)createRelationshipsForDestinationInstance:(NSManagedObject *)dInstance entityMapping:(NSEntityMapping *)mapping manager:(NSMigrationManager *)manager error:(NSError * _Nullable __autoreleasing *)error {
    return YES;
}

@end
