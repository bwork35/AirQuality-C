//
//  BJWCityAirQuality.m
//  AirQuality ObjC
//
//  Created by Bryan Workman on 6/24/20.
//  Copyright © 2020 RYAN GREENBURG. All rights reserved.
//

#import "BJWCityAirQuality.h"
#import "BJWWeather.h"
#import "BJWPollution.h"

@implementation BJWCityAirQuality

- (instancetype)initWithCity:(NSString *)city state:(NSString *)state country:(NSString *)country weather:(BJWWeather *)weather pollution:(BJWPollution *)pollution
{
    self = [super init];
    
    if (self)
    {
        _city = city;
        _state = state;
        _country = country;
        _weather = weather;
        _pollution = pollution;
    }
    
    return self;
}

@end

@implementation BJWCityAirQuality (JSONConvertable)

- (instancetype)initWithDictionary:(NSDictionary<NSString *,id> *)dictionary
{
    NSString *city = dictionary[@"city"];
    NSString *state = dictionary[ @"state"];
    NSString *country = dictionary [@"country"];
    
    NSDictionary *currentInfo = dictionary[@"current"];
    BJWWeather *weather = [[BJWWeather alloc] initWithDictionary:currentInfo[@"weather"]];
    BJWPollution *pollution = [[BJWPollution alloc] initWithDictionary:currentInfo[@"pollution"]];
    
    return [self initWithCity:city state:state country:country weather:weather pollution:pollution];
}

@end
