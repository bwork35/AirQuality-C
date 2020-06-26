//
//  BJWPollution.h
//  AirQuality ObjC
//
//  Created by Bryan Workman on 6/24/20.
//  Copyright © 2020 RYAN GREENBURG. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface BJWPollution : NSObject

@property (nonatomic, readonly) NSInteger airQualityIndex;

-(instancetype) initWithInt:(NSInteger) aqi;

@end

@interface BJWPollution (JSONConvertable)
-(instancetype)initWithDictionary:(NSDictionary<NSString *, id>*)dictionary;

@end

NS_ASSUME_NONNULL_END
