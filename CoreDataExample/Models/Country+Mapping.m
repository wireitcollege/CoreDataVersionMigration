//
//  Country+Mapping.m
//  CoreDataExample
//
//  Created by Admin on 12/14/15.
//  Copyright © 2015 Wire IT College. All rights reserved.
//

#import "Country+Mapping.h"
#import "NSManagedObject+CoreData.h"

@implementation Country (Mapping)

+ (instancetype)countryWithDictionary:(NSDictionary *)dictionary inContext:(NSManagedObjectContext *)context {
    NSString *name = [dictionary valueForKey:@"name"];
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"name == %@", name];
    Country *country = [Country findFirstWithPredicate:predicate inContext:context];
    if (!country) {
        country = [Country createEntityInContext:context];
        country.name = name;
    }
    
    country.capital     = [dictionary valueForKey:@"capital"];
    country.population  = [dictionary valueForKey:@"population"];
    country.nativeName  = [dictionary valueForKey:@"nativeName"];
    country.region      = [dictionary valueForKey:@"region"];
    
    id area = [dictionary valueForKey:@"area"];
    if ([area isKindOfClass:[NSString class]]) {
        NSNumberFormatter *formatter = [NSNumberFormatter new];
        formatter.numberStyle = NSNumberFormatterDecimalStyle;
        area = [formatter numberFromString:area];
    }
    
    if ([area isKindOfClass:[NSNull class]]) {
        area = nil;
    }
    
    country.area        = area;
    
    NSArray *latlng = [dictionary valueForKey:@"latlng"];
    country.latitude    = latlng.firstObject;
    country.longitude   = latlng.lastObject;
    
    return country;
}

@end
