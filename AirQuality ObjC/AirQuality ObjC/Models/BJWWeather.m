//
//  BJWWeather.m
//  AirQuality ObjC
//
//  Created by Bryan Workman on 6/24/20.
//  Copyright © 2020 RYAN GREENBURG. All rights reserved.
//

#import "BJWWeather.h"

@implementation BJWWeather

- (instancetype)initWithWeather:(NSInteger )temperature humidity:(NSInteger )humidity windspeed:(NSInteger )windspeed
{
    self = [self init];
       if (self) {
           _temperature = temperature;
           _humidity = humidity;
           _windspeed = windspeed;
       }
       return self;
}

@end

@implementation BJWWeather (JSONConvertable)

- (instancetype)initWithDictionary:(NSDictionary<NSString *,id> *)dictionary
{
    NSInteger temperature = [dictionary[@"tp"] intValue];
    NSInteger humidity = [dictionary[@"hu"] intValue];
    NSInteger windspeed = [dictionary[@"ws"] intValue];
    
    return [self initWithWeather:temperature humidity:humidity windspeed:windspeed];
}

@end
