//
//  CountryAPI.m
//  CoreDataExample
//
//  Created by Admin on 12/14/15.
//  Copyright © 2015 Wire IT College. All rights reserved.
//

#import "CountryAPI.h"
#import "Country+Mapping.h"
#import "NSManagedObjectContext+MainContext.h"

static NSString *const kBaseURL = @"https://restcountries.eu/rest/v1";

@interface CountryAPI ()
@property (nonatomic, strong) NSURLSession *session;
@property (nonatomic, strong) NSURLSessionConfiguration *sessionConfig;
@end

@implementation CountryAPI

+ (instancetype)sharedService {
    static id instance;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        instance = [[self alloc] init];
    });
    return instance;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

#pragma NSURLSession

- (NSURLSessionConfiguration *)sessionConfig {
    if (_sessionConfig) {
        return _sessionConfig;
    }
    
    _sessionConfig = [NSURLSessionConfiguration ephemeralSessionConfiguration];
    [_sessionConfig setHTTPAdditionalHeaders:@{@"Accept": @"application/json"}];
    _sessionConfig.timeoutIntervalForRequest = 30.f;
    _sessionConfig.timeoutIntervalForResource = 30.f;
    _sessionConfig.HTTPMaximumConnectionsPerHost = 1;
    
    return _sessionConfig;
}

- (NSURLSession *)session {
    if (_session) {
        return _session;
    }
    
    _session = [NSURLSession sessionWithConfiguration:self.sessionConfig
                                             delegate:nil
                                        delegateQueue:nil];
    
    return _session;
}

#pragma mark - API Calls

- (void)loadCountries:(void (^)(id result, NSError *error))completion {
    
    NSURLComponents *components = [NSURLComponents new];
    components.scheme       = @"https";
    components.host         = @"restcountries.eu";
    components.path         = @"/rest/v1/all";

//    NSURLQueryItem *query1  = [NSURLQueryItem queryItemWithName:@"format" value:@"xml"];
//    NSURLQueryItem *query2  = [NSURLQueryItem queryItemWithName:@"extras" value:@"owner_name"];
//    components.queryItems   = @[query1, query2];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:components.URL];
    NSURLSessionTask *task = [self.session dataTaskWithRequest:request
                                             completionHandler:^(NSData *data, NSURLResponse *response, NSError *error)
    {
        NSError *taskError = error;
        if (!taskError) {
            
            id parsedObject = [NSJSONSerialization JSONObjectWithData:data options:0 error:&taskError];
            
            if (!taskError) {
                
                NSManagedObjectContext *context = [NSManagedObjectContext backgroundContext];
                
                if ([parsedObject isKindOfClass:[NSArray class]]) {
                    NSArray *coutries = parsedObject;
                    for (NSDictionary *countryObject in coutries) {
                        [Country countryWithDictionary:countryObject inContext:context];
                    }
                    
                    [context performBlockAndWait:^{
                        [context save:NULL];
                        [context.parentContext performBlock:^{
                            [context.parentContext save:NULL];
                        }];
                    }];
                }
                
            }
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            if (completion) completion(nil, taskError);
        });
    }];
    
    [task resume];
}

@end
