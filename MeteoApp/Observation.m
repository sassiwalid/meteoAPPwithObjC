//
//  Observation.m
//  MeteoApp
//
//  Created by MacBook Pro on 20/02/2017.
//  Copyright © 2017 MacBook Pro. All rights reserved.
//

#import "Observation.h"

@implementation Observation
// intialize observation attributs
@synthesize weatherDescription;
@synthesize temperatureDescription;
@synthesize iconUrl;
@synthesize temperatureMax;
@synthesize temperatureMin;
@synthesize temperatureNight;
@synthesize temperatureEvening;
@synthesize temperatureMorning;
@synthesize humidity;
@synthesize pressure;
-(id)initWithName:(NSString *)weatherDescription_ message:(NSString *)temperatureDescription_ iconUrl:(NSString *)iconUrl_ temperatureMax:(NSString *)temperatureMax_ Min:(NSString *)temperatureMin_ tempNight:(NSString*)temperatureNight_ tempEven:(NSString*)temperatureEvening_ tempMorning:(NSString*)temperatureMorning_
         pressure:(NSString*)pressure_ Humidity:(NSString*)humidity_
{
    self = [super init];
    if (self) {
        self.weatherDescription = weatherDescription_;
        self.temperatureDescription = temperatureDescription_;
        self.iconUrl = iconUrl_;
        self.temperatureMax = temperatureMax_;
        self.temperatureMin = temperatureMin_;
        self.temperatureNight = temperatureNight_;
        self.temperatureEvening = temperatureEvening_;
        self.temperatureMorning = temperatureMorning_;
        self.pressure = pressure_;
        self.humidity = humidity_;
    }
    return self;
}
@end
