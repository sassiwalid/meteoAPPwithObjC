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
-(id)initWithName:(NSString *)weatherDescription_ message:(NSString *)temperatureDescription_ iconUrl:(NSString *)iconUrl_
{
    self = [super init];
    if (self) {
        self.weatherDescription = weatherDescription_;
        self.temperatureDescription = temperatureDescription_;
        self.iconUrl = iconUrl_;
    }
    return self;
}
@end
