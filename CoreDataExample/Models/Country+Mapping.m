//
//  Country+Mapping.m
//  CoreDataExample
//
//  Created by Admin on 12/14/15.
//  Copyright © 2015 Wire IT College. All rights reserved.
//

#import "Country+Mapping.h"
#import "NSManagedObject+CoreData.h"
#import "Region+CoreDataProperties.h"

@implementation Country (Mapping)

+ (instancetype)countryWithDictionary:(NSDictionary *)json inContext:(NSManagedObjectContext *)context {
    NSString *name = [json valueForKey:@"name"];
    
    NSPredicate *byCountry = [NSPredicate predicateWithFormat:@"name == %@", name];
    Country *country = [Country findFirstWithPredicate:byCountry inContext:context];
    if (!country) {
        country = [Country createEntityInContext:context];
        country.name = name;
    }

    country.capital     = [json valueForKey:@"capital"];
    country.population  = [json valueForKey:@"population"];
    country.nativeName  = [json valueForKey:@"nativeName"];
    
    NSString *regionName = [json valueForKey:@"region"];
    NSPredicate *byRegion = [NSPredicate predicateWithFormat:@"name = %@", regionName];
    Region *region = [Region findFirstWithPredicate:byRegion inContext:context];
    if (!region) {
        region = [Region createEntityInContext:context];
        region.name = regionName;
    }
    
    country.region      = region;
    
    id area = [json valueForKey:@"area"];
    if ([area isKindOfClass:[NSString class]]) {
        NSNumberFormatter *formatter = [NSNumberFormatter new];
        formatter.numberStyle = NSNumberFormatterDecimalStyle;
        area = [formatter numberFromString:area];
    }
    
    if ([area isKindOfClass:[NSNull class]]) {
        area = nil;
    }
    
    country.area        = area;
    
    NSArray *latlng = [json valueForKey:@"latlng"];
    country.latitude    = latlng.firstObject;
    country.longitude   = latlng.lastObject;
    
    return country;
}

@end
