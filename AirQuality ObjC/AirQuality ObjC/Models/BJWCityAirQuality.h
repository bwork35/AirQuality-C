//
//  BJWCityAirQuality.h
//  AirQuality ObjC
//
//  Created by Bryan Workman on 6/24/20.
//  Copyright © 2020 RYAN GREENBURG. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BJWWeather.h"
#import "BJWPollution.h"

NS_ASSUME_NONNULL_BEGIN

@interface BJWCityAirQuality : NSObject

@property (nonatomic, copy, readonly) NSString *city;
@property (nonatomic, copy, readonly) NSString *state;
@property (nonatomic, copy, readonly) NSString *country;
@property (nonatomic, copy, readonly) BJWWeather *weather;
@property (nonatomic, copy, readonly) BJWPollution *pollution;

- (instancetype)initWithCity:(NSString *)city state:(NSString *)state country:(NSString *)country weather:(BJWWeather *)weather pollution:(BJWPollution *)pollution;

@end

@interface BJWCityAirQuality (JSONConvertable)
-(instancetype)initWithDictionary:(NSDictionary<NSString *, id>*)dictionary;

@end

NS_ASSUME_NONNULL_END
