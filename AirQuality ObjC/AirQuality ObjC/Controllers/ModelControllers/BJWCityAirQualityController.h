//
//  BJWCityAirQualityController.h
//  AirQuality ObjC
//
//  Created by Bryan Workman on 6/24/20.
//  Copyright © 2020 RYAN GREENBURG. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BJWCityAirQuality.h"

NS_ASSUME_NONNULL_BEGIN

@interface BJWCityAirQualityController : NSObject

+(void)fetchSupportedCountries: (void (^) (NSArray<NSString *> *_Nullable))completion;

+(void)fetchSupportedStatesInCountry: (NSString *)country completion:(void (^) (NSArray<NSString *>* _Nullable))completion;

+(void)fetchSupportedCitiesInState: (NSString *)state country: (NSString *)country completion:(void (^) (NSArray<NSString *>* _Nullable))completion;

+(void)fetchDataForCity: (NSString *)city state: (NSString *)state country:(NSString *)country completion:(void (^) (BJWCityAirQuality *_Nullable))completion;


@end

NS_ASSUME_NONNULL_END
