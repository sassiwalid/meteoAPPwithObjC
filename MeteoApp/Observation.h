//
//  Observation.h
//  MeteoApp
//
//  Created by MacBook Pro on 20/02/2017.
//  Copyright © 2017 MacBook Pro. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Realm/Realm.h>
@interface Observation : RLMObject
@property (nonatomic, strong) NSString  *weatherDescription;
@property (nonatomic, strong) NSString  *temperatureDescription;
@property (nonatomic, strong) NSString  *iconUrl;
@end
