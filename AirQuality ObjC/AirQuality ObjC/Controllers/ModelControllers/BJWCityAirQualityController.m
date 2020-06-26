//
//  BJWCityAirQualityController.m
//  AirQuality ObjC
//
//  Created by Bryan Workman on 6/24/20.
//  Copyright © 2020 RYAN GREENBURG. All rights reserved.
//

#import "BJWCityAirQualityController.h"

static NSString *const baseURLString = @"https://api.airvisual.com";
static NSString *const versionComponent = @"v2";
static NSString *const countryComponent = @"countries";
static NSString *const stateComponent = @"states";
static NSString *const cityComponent = @"cities";
static NSString *const cityDetailsComponent = @"city";
static NSString *const apiKey = @"d7b412a8-951b-4711-9792-66f9f144752a";

@implementation BJWCityAirQualityController

+ (void)fetchSupportedCountries:(void (^)(NSArray<NSString *> * _Nullable))completion
{
    NSURL *baseURL = [NSURL URLWithString:baseURLString];
    NSURL *versionURL = [baseURL URLByAppendingPathComponent:versionComponent];
    NSURL *countryURL = [versionURL URLByAppendingPathComponent:countryComponent];
    
    NSMutableArray<NSURLQueryItem *> *queryItems = [NSMutableArray new];
    NSURLQueryItem *apiKeyQuery = [[NSURLQueryItem alloc] initWithName:@"key" value:apiKey];
    [queryItems addObject:apiKeyQuery];
    
    NSURLComponents *urlComponents = [[NSURLComponents alloc] initWithURL:countryURL resolvingAgainstBaseURL: true];
    
    [urlComponents setQueryItems: queryItems];
    NSURL *finalURL = [urlComponents URL];
    
    [[[NSURLSession sharedSession]
      dataTaskWithURL: finalURL
      completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        if (error)
        {
            NSLog(@"There was an error fetching the country: %@, %@", error, [error localizedDescription]);
            return completion(nil);
        }
        
        if (data)
        {
            NSDictionary *topLevelDictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
            
            if (!topLevelDictionary)
            {
                NSLog(@"Error parsing the data: %@", error);
                return completion(nil);
            }
            
            NSDictionary *dataDictionary = topLevelDictionary[@"data"];
            NSMutableArray *countries = [NSMutableArray new];
            for (NSDictionary *countryDictionary in dataDictionary) {
                NSString *country = [[NSString alloc] initWithString:countryDictionary[@"country"]];
                [countries addObject:country];
            }
            completion(countries);
        }
    }]resume];
}

+ (void)fetchSupportedStatesInCountry:(NSString *)country completion:(void (^)(NSArray<NSString *> * _Nullable))completion
{
    
    NSURL *baseURL = [NSURL URLWithString:baseURLString];
    NSURL *versionURL = [baseURL URLByAppendingPathComponent:versionComponent];
    NSURL *stateURL = [versionURL URLByAppendingPathComponent:stateComponent];
    
    NSMutableArray<NSURLQueryItem *> *queryItems = [NSMutableArray new];
    
    NSURLQueryItem *countryQuery = [[NSURLQueryItem alloc] initWithName:@"country" value:country];
    NSURLQueryItem *apiKeyQuery = [[NSURLQueryItem alloc] initWithName:@"key" value:apiKey];
    
    [queryItems addObject:countryQuery];
    [queryItems addObject:apiKeyQuery];
    
    
    NSURLComponents *urlComponents = [[NSURLComponents alloc] initWithURL:stateURL resolvingAgainstBaseURL: true];
    
    [urlComponents setQueryItems: queryItems];
    NSURL *finalURL = [urlComponents URL];
    
    [[[NSURLSession sharedSession]
      dataTaskWithURL: finalURL
      completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        if (error)
        {
            NSLog(@"There was an error fetching the state: %@, %@", error, [error localizedDescription]);
            return completion(nil);
        }
        
        if (data)
        {
            NSDictionary *topLevelDictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
            
            if (!topLevelDictionary)
            {
                NSLog(@"Error parsing the data: %@", error);
                return completion(nil);
            }
            
            NSDictionary *dataDictionary = topLevelDictionary[@"data"];
            
            NSMutableArray *states = [NSMutableArray new];
            for (NSDictionary *statesDictionary in dataDictionary)
            {
                NSString *state = statesDictionary[@"state"];
                [states addObject:state];
            }
            completion(states);
        }
    }]resume];
}

+ (void)fetchSupportedCitiesInState:(NSString *)state country:(NSString *)country completion:(void (^)(NSArray<NSString *> * _Nullable))completion
{
    NSURL *baseURL = [NSURL URLWithString:baseURLString];
    NSURL *versionURL = [baseURL URLByAppendingPathComponent:versionComponent];
    NSURL *cityURL = [versionURL URLByAppendingPathComponent:cityComponent];
    
    NSMutableArray<NSURLQueryItem *> *queryItems = [NSMutableArray new];
    
    NSURLQueryItem *stateQuery = [[NSURLQueryItem alloc] initWithName:@"state" value:state];
    NSURLQueryItem *countryQuery = [[NSURLQueryItem alloc] initWithName:@"country" value:country];
    NSURLQueryItem *apiKeyQuery = [[NSURLQueryItem alloc] initWithName:@"key" value:apiKey];
    
    [queryItems addObject:stateQuery];
    [queryItems addObject:countryQuery];
    [queryItems addObject:apiKeyQuery];
    
    NSURLComponents *urlComponents = [[NSURLComponents alloc] initWithURL:cityURL resolvingAgainstBaseURL: true];
    
    [urlComponents setQueryItems: queryItems];
    NSURL *finalURL = [urlComponents URL];
    
    [[[NSURLSession sharedSession]
      dataTaskWithURL: finalURL
      completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        if (error)
        {
            NSLog(@"There was an error fetching the city: %@, %@", error, [error localizedDescription]);
            return completion(nil);
        }
        
        if (data)
        {
            NSDictionary *topLevelDictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
            
            if (!topLevelDictionary)
            {
                NSLog(@"Error parsing the data: %@", error);
                return completion(nil);
            }
            
            NSDictionary *dataDictionary = topLevelDictionary[@"data"];
            NSMutableArray *cities = [NSMutableArray new];
            
            for (NSDictionary *cityDictionary in dataDictionary) {
                NSString *city = cityDictionary[@"city"];
                [cities addObject:city];
            }
            completion(cities);
        }
    }]resume];
}

+ (void)fetchDataForCity:(NSString *)city state:(NSString *)state country:(NSString *)country completion:(void (^)(BJWCityAirQuality * _Nullable))completion
{
    NSURL *baseURL = [NSURL URLWithString:baseURLString];
    NSURL *versionURL = [baseURL URLByAppendingPathComponent:versionComponent];
    NSURL *cityURL = [versionURL URLByAppendingPathComponent:cityDetailsComponent];
    
    NSMutableArray<NSURLQueryItem *> *queryItems = [NSMutableArray new];
    
    NSURLQueryItem *cityQuery = [[NSURLQueryItem alloc] initWithName:@"city" value:city];
    NSURLQueryItem *stateQuery = [[NSURLQueryItem alloc] initWithName:@"state" value:state];
    NSURLQueryItem *countryQuery = [[NSURLQueryItem alloc] initWithName:@"country" value:country];
    NSURLQueryItem *apiKeyQuery = [[NSURLQueryItem alloc] initWithName:@"key" value:apiKey];
    
    [queryItems addObject:cityQuery];
    [queryItems addObject:stateQuery];
    [queryItems addObject:countryQuery];
    [queryItems addObject:apiKeyQuery];
    
    NSURLComponents *urlComponents = [[NSURLComponents alloc] initWithURL:cityURL resolvingAgainstBaseURL: true];
    
    [urlComponents setQueryItems: queryItems];
    NSURL *finalURL = [urlComponents URL];
    
    [[[NSURLSession sharedSession]
      dataTaskWithURL: finalURL
      completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        if (error)
        {
            NSLog(@"There was an error fetching the city details: %@, %@", error, [error localizedDescription]);
            return completion(nil);
        }
        
        if (data)
        {
            NSDictionary *topLevelDictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
            NSDictionary *dataDictionary = topLevelDictionary[@"data"];
            
            BJWCityAirQuality *cityAQI = [[BJWCityAirQuality alloc] initWithDictionary:dataDictionary];
            completion(cityAQI);
        }
    }]resume];
}

@end
