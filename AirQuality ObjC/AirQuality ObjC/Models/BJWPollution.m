//
//  BJWPollution.m
//  AirQuality ObjC
//
//  Created by Bryan Workman on 6/24/20.
//  Copyright © 2020 RYAN GREENBURG. All rights reserved.
//

#import "BJWPollution.h"

@implementation BJWPollution

- (instancetype)initWithInt:(NSInteger)aqi
{
    self = [self init];
    if (self) {
        _airQualityIndex = aqi;
    }
    return self;
}

@end

@implementation BJWPollution (JSONConvertable)

- (instancetype)initWithDictionary:(NSDictionary<NSString *,id> *)dictionary
{
    NSInteger aqi = [dictionary[@"aqius"] intValue];
    
    return [self initWithInt:aqi];
}

@end
